package com.redhat.cloudnative.service;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import com.redhat.cloudnative.model.ShoppingCart;

import io.quarkus.redis.datasource.ReactiveRedisDataSource;
import io.quarkus.redis.datasource.RedisDataSource;
import io.quarkus.redis.datasource.hash.HashCommands;
import io.vertx.mutiny.redis.client.RedisAPI;

@ApplicationScoped
public class CacheService {
    @Inject 
    ReactiveRedisDataSource reactiveDataSource;
    @Inject 
    RedisDataSource redisDataSource;
    @Inject 
    RedisAPI redisAPI;
    
    private static final String MY_KEY = "my-key";

    private final HashCommands<String, String, ShoppingCart> commands;

    public CacheService(RedisDataSource ds) { 
        commands = ds.hash(ShoppingCart.class); 
    }

    public boolean containsKey(String field) {
        return commands.hexists(MY_KEY, field);
    }

    public void put(String field, ShoppingCart value) {
        this.set(field, value);
    }

    public void set(String field, ShoppingCart value) {
        commands.hset(MY_KEY, field, value);  
    }

    public ShoppingCart get(String field) {
        return commands.hget(MY_KEY, field);  
    }
}

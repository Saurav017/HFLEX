package org.hflex.ledger.api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Clock;
import java.time.Instant;
import java.util.Map;

@RestController
@RequestMapping("v1/health")
public class HealthController {

    private final Clock clock;
    public HealthController(Clock clock) {
        this.clock = clock;
    }

    @GetMapping
    public Map<String, Object> health() {
        return Map.of(
                "status", "OK",
                "time", Instant.now(clock).toString()
        );
    }

}

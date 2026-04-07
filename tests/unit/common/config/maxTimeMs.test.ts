import { describe, expect, it } from "vitest";
import { UserConfigSchema } from "../../../../src/common/config/userConfig.js";

describe("maxTimeMs config option", () => {
    it("should have a default value of 60000", () => {
        const config = UserConfigSchema.parse({});
        expect(config.maxTimeMs).toBe(60_000);
    });

    it("should accept a custom value", () => {
        const config = UserConfigSchema.parse({ maxTimeMs: 10_000 });
        expect(config.maxTimeMs).toBe(10_000);
    });

    it("should coerce string values to numbers", () => {
        const config = UserConfigSchema.parse({ maxTimeMs: "5000" });
        expect(config.maxTimeMs).toBe(5000);
    });

    it("should accept 0 to disable maxTimeMS", () => {
        const config = UserConfigSchema.parse({ maxTimeMs: 0 });
        expect(config.maxTimeMs).toBe(0);
    });

    it("should reject negative values", () => {
        expect(() => UserConfigSchema.parse({ maxTimeMs: -5 })).toThrow();
    });
});

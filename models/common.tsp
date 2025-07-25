
import "@typespec/json-schema";

using TypeSpec.JsonSchema;

namespace rpp.common {
    @doc("Parameters specific to the transfer of a domain.")
    @jsonSchema
    model TransferAck {
        @doc("Reason for the transfer approval, if applicable.")
        reason: string;
    }

    @doc("Parameters specific to the transfer of a domain.")
    @jsonSchema
    model TransferNack {
        @doc("Reason for the transfer approval, if applicable.")
        reason: string;
    }

    enum TransferStatus {
        @doc("The transfer is pending approval.")
        pending,
        @doc("The transfer has been approved.")
        approved,
        @doc("The transfer has been rejected.")
        rejected,
        @doc("The transfer has been cancelled.")
        cancelled,
        @doc("The transfer has been completed successfully.")
        completed
    };

    model TransferableProvisioninigObj extends ProvisioningObj {
        authInfo: {
            pw?: string;
            hash?: string;
        };
    }

    model ProvisioningObj extends ProvisioningObjMinimal{
        @visibility(Lifecycle.Read, Lifecycle.Query) status?: string[];
        @visibility(Lifecycle.Read, Lifecycle.Query) upDate?: string;
        @visibility(Lifecycle.Read, Lifecycle.Query) trDate?: string;
        @visibility(Lifecycle.Read, Lifecycle.Query) clID?: string;
        @visibility(Lifecycle.Read, Lifecycle.Query) crID?: string;
    }

    model ProvisioningObjMinimal {
        @visibility(Lifecycle.Read, Lifecycle.Query) crDate?: string;
        @visibility(Lifecycle.Read, Lifecycle.Query) exDate?: string;
    }

    model CheckResponse {
        @doc("The status of the check operation, indicating whether the entity is available or not.")
        available: boolean;
    }
}
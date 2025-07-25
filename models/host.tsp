import "@typespec/json-schema";
import "./common.tsp";
import "./dns.tsp";

using TypeSpec.JsonSchema;

namespace rpp.host {

    @doc("Nameserver of a domain, either a EPP-style hostAttr or a reference of a hostObj by name. Host objects are used for nameservers that are registered in the registry, while host attributes are used for nameservers that are not registered in the registry but are associated with the domain.")
    model NS {
        ns?: DomainEPPHostAttr | DomainHostObj ;
    }

    @doc("EPP-stype hostAttr")
    model DomainEPPHostAttr {
        hostAttr: EPPHost[]
    }

    model DomainHostObj {
        @doc("Host object can be described either EPP-style (rpp.host.EPPHost) or DNS-style (rpp.host.DNSHost). Both variants must be used mutual exclusive.")
        hostObj: HostName[];
    }

    model HostName {
        name: string;
    }

    model HostAddress {
        addr?: {
            "ipv4"?: string[];
            "ipv6"?: string[];
        };
    }

    @doc("Host object can be described either EPP-style (rpp.host.EPPHost) or DNS-style (rpp.host.DNSHost). Both variants must be used mutual exclusive.")
    model EPPHost {
        ...HostName;
        ...HostAddress
    }

    @doc("Host object can be described either EPP-style (rpp.host.EPPHost) or DNS-style (rpp.host.DNSHost). Both variants must be used mutual exclusive.")
    model DNSHost {
        ...HostName;
        ...rpp.dns.DNS;
    }

    @jsonSchema
    @mediaTypeHint("application/rpp+json")
    @doc("Host object can be described either EPP-style (rpp.host.EPPHost) or DNS-style (rpp.host.DNSHost). Both variants must be used mutual exclusive.")
    model Host {
        ...EPPHost;
        ...rpp.dns.DNS;
        ...rpp.common.ProvisioningObj;
    }
}

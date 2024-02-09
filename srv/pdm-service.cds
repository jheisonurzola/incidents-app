using {sap.capire.incidents as db} from '../db/schema';

@requires: 'PersonalDataManagerUser' // security check
service PDMService @(path: '/pdm') {

    // Data Privacy annotations on 'Customers' and 'Addresses' are derived from original entity definitions
    entity Customers                as projection on db.Customers;
    entity Addresses                as projection on db.Addresses;
    entity Incidents                as projection on db.Incidents

    // create view on Incidents and Conversations as flat projection
    entity IncidentConversationView as
        select from Incidents {
                ID,
                title,
                urgency,
                status,
            key conversation.ID        as conversation_ID,
                conversation.timestamp as conversation_timestamp,
                conversation.author    as conversation_author,
                conversation.message   as conversation_message,
                customer.ID            as customer_ID,
                customer.email         as customer_email
        };

    // annotate new view
    annotate PDMService.IncidentConversationView with @(PersonalData.EntitySemantics: 'Other') {
        customer_ID @PersonalData.FieldSemantics: 'DataSubjectID';
    };

    // annotations for Personal Data Manager - Search Fields
    annotate Customers with @(Communication.Contact: {
        n    : {
            surname: lastName,
            given  : firstName
        },
        email: EMailAddress //how to use the type here?
    });

};

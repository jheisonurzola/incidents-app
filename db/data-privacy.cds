using {sap.capire.incidents as my} from '../db/schema';

annotate my.Customers with @PersonalData     : {
    DataSubjectRole: 'Customer',
    EntitySemantics: 'DataSubject'
} {
    ID           @PersonalData.FieldSemantics: 'DataSubjectID';
    firstName    @PersonalData.IsPotentiallyPersonal;
    lastName     @PersonalData.IsPotentiallyPersonal;
    email        @PersonalData.IsPotentiallyPersonal  @Communication.IsEmailAddress;
    phone        @PersonalData.IsPotentiallyPersonal;
    dateOfBirth  @PersonalData.IsPotentiallyPersonal;
    creditCardNo @PersonalData.IsPotentiallySensitive;
};

annotate my.Addresses with @PersonalData      : {EntitySemantics: 'DataSubjectDetails'} {
    customer      @PersonalData.FieldSemantics: 'DataSubjectID';
    city          @PersonalData.IsPotentiallyPersonal;
    postCode      @PersonalData.IsPotentiallyPersonal;
    streetAddress @PersonalData.IsPotentiallyPersonal;
};

annotate my.Incidents with @PersonalData : {EntitySemantics: 'Other'} {
    customer @PersonalData.FieldSemantics: 'DataSubjectID';
};

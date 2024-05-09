using app.fashionShop from '../db/fashionShop';

//Service
service fashionShop_Service {
    entity Sections      as projection on fashionShop.Sections;
    entity Fashion_Types as projection on fashionShop.Fashion_Types;
    entity Fashion_Items as projection on fashionShop.Fashion_Items;

    //Service for the CDS View
    entity Srv_FashionShop as projection on fashionShop.YC_FashionShop;
}

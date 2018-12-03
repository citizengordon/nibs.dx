// Copyright 2015, Gordon Jackson - Sales Engineering, Salesforce.com Inc.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer. 
// - Redistributions in binary form must reproduce the above copyright notice, 
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the salesforce.com nor the names of its contributors
//   may be used to endorse or promote products derived from this software
//   without specific prior written permission. 
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

public with sharing class NibsDataLoader {
    // There are 2 files installed in the Static Resources
    private String productFile = 'eLoyalty_ProductsJSON';
    private String campaignFile = 'eLoyalty_CampaignsJSON';
    private String storeFile = 'eLoyalty_StoresJSON';
    
    // These two files contain sample Loyalty Products and Offers (Campaigns)
    @TestVisible private StaticResource productJSON;
    @TestVisible private StaticResource campaignJSON;
    @TestVisible private StaticResource storeJSON;
    
    public NibsDataLoader() {
        // The Static Resources are retrieved
        productJSON = [Select Body From StaticResource Where Name = :productFile];
        campaignJSON = [Select Body From StaticResource Where Name = :campaignFile];        
        storeJSON = [Select Body From StaticResource Where Name = :storeFile];
    }
    
    public void installData () {
        // Records are created and inserted
        // 
        String products = (productJSON.Body).toString();
        List<Product2> pList = (List<Product2>)JSON.deserialize(products, List<Product2>.class);
        insert pList;
        
        String campaigns = (campaignJSON.Body).toString();
        List<Campaign> cList = (List<Campaign>)JSON.deserialize(campaigns, List<Campaign>.class);
        insert cList;
        
        String stores = (storeJSON.Body).toString();
        List<Store__c> sList = (List<Store__c>)JSON.deserialize(stores, List<Store__c>.class);
        insert sList;
    }
}
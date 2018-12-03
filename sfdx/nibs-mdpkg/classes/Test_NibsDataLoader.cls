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

@isTest
private class Test_NibsDataLoader {
    static NibsDataLoader ndl;
    
    //test the NibsDataLoader ctor
    @isTest static void testNibsDataLoaderConstructor() {
        ndl = new NibsDataLoader();
        
        System.assert((ndl.productJSON != null), 'The Product JSON Static Resource did not load succesfully');
        System.assert((ndl.campaignJSON != null), 'The Campaign JSON Static Resource did not load succesfully');
    }
    
    //test the installData method
    @isTest static void testInstallData() {
        ndl = new NibsDataLoader();
        ndl.installData();
        
        Integer pCount = [SELECT count() FROM Product2];
        System.assert((pCount == 13), 'There should be 13 Products');
        
        Integer cCount = [SELECT count() FROM Campaign];
        System.assert((cCount == 8), 'There should be 8 Campaigns');
    }
}
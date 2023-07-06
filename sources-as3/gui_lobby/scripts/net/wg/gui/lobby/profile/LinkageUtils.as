package net.wg.gui.lobby.profile
{
   public class LinkageUtils
   {
       
      
      private var linkageByAlias:Object;
      
      private var aliasesByLinkage:Object;
      
      public function LinkageUtils()
      {
         this.linkageByAlias = {};
         this.aliasesByLinkage = {};
         super();
      }
      
      public function addEntity(param1:String, param2:String) : void
      {
         this.linkageByAlias[param1] = param2;
         this.aliasesByLinkage[param2] = param1;
      }
      
      public function updateEntityWithLinkage(param1:String, param2:String) : void
      {
         if(this.aliasesByLinkage[param1])
         {
            delete this.linkageByAlias[this.aliasesByLinkage[param1]];
            this.addEntity(param2,param1);
         }
      }
      
      public function getLinkageByAlias(param1:String) : String
      {
         return this.linkageByAlias[param1];
      }
      
      public function getAliasByLinkage(param1:String) : String
      {
         return this.aliasesByLinkage[param1];
      }
      
      public function dispose() : void
      {
         this.linkageByAlias = App.utils.data.cleanupDynamicObject(this.linkageByAlias);
         this.aliasesByLinkage = App.utils.data.cleanupDynamicObject(this.aliasesByLinkage);
      }
   }
}

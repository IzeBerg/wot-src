package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.battleMatters.data.MissionLinkedSetBodyVO;
   import net.wg.gui.lobby.premiumMissions.data.MissionPremiumBodyVO;
   
   public class MissionsPackVO extends DAAPIDataClass
   {
      
      private static const BODY_DATA_FIELD:String = "bodyData";
      
      private static const BODY_DATA_LINKED_SET_FIELD:String = "bodyDataLinkedSet";
      
      private static const BODY_DATA_PREMIUM_FIELD:String = "bodyDataPremium";
      
      private static const BLOCK_ID:String = "blockId";
       
      
      public var blockId:String = "";
      
      public var headerLinkage:String = "";
      
      public var bodyLinkage:String = "";
      
      public var headerData:Object;
      
      public var bodyData:Object;
      
      public var bodyDataLinkedSet:MissionLinkedSetBodyVO = null;
      
      public var bodyDataPremium:MissionPremiumBodyVO = null;
      
      public var isCollapsed:Boolean = false;
      
      public var isLinkedSet:Boolean = false;
      
      public var isPremium:Boolean = false;
      
      public var bgAlpha:Number = 0.5;
      
      public function MissionsPackVO(param1:Object)
      {
         this.blockId = param1[BLOCK_ID];
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BODY_DATA_FIELD)
         {
            this.bodyData = new this.dataClass(param2,this.blockId);
            return false;
         }
         if(param1 == BODY_DATA_LINKED_SET_FIELD)
         {
            this.bodyDataLinkedSet = new MissionLinkedSetBodyVO(param2,this.blockId);
            return false;
         }
         if(param1 == BODY_DATA_PREMIUM_FIELD)
         {
            this.bodyDataPremium = new MissionPremiumBodyVO(param2,this.blockId);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this.headerData);
         this.headerData = null;
         if(this.bodyData != null)
         {
            this.bodyData.dispose();
            this.bodyData = null;
         }
         if(this.bodyDataLinkedSet != null)
         {
            this.bodyDataLinkedSet.dispose();
            this.bodyDataLinkedSet = null;
         }
         if(this.bodyDataPremium != null)
         {
            this.bodyDataPremium.dispose();
            this.bodyDataPremium = null;
         }
         super.onDispose();
      }
      
      protected function get dataClass() : Class
      {
         return MissionPackMarathonBodyVO;
      }
   }
}

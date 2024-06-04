package net.wg.gui.lobby.profile.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProfileMenuInfoVO extends DAAPIDataClass
   {
      
      private static const TAB_BAR_DATA:String = "tabBarData";
       
      
      public var tabBarData:Vector.<SectionInfoVO> = null;
      
      public var selectedAlias:String = "";
      
      public function ProfileMenuInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TAB_BAR_DATA && param2 != null)
         {
            this.tabBarData = Vector.<SectionInfoVO>(App.utils.data.convertVOArrayToVector(param1,param2,SectionInfoVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SectionInfoVO = null;
         if(this.tabBarData != null)
         {
            for each(_loc1_ in this.tabBarData)
            {
               _loc1_.dispose();
            }
            this.tabBarData.fixed = false;
            this.tabBarData.splice(0,this.tabBarData.length);
            this.tabBarData = null;
         }
         super.onDispose();
      }
   }
}

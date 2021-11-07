package net.wg.gui.lobby.profile.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class ProfileBattleTypeInitVO extends DAAPIDataClass
   {
      
      private static const DROP_DOWN_PROVIDER:String = "dropDownProvider";
       
      
      public var dropDownProvider:DataProvider = null;
      
      public function ProfileBattleTypeInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(DROP_DOWN_PROVIDER == param1)
         {
            this.dropDownProvider = new DataProvider(param2 as Array);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.dropDownProvider)
         {
            this.dropDownProvider.cleanUp();
            this.dropDownProvider = null;
         }
         super.onDispose();
      }
   }
}

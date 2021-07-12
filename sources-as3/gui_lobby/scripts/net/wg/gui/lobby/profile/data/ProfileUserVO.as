package net.wg.gui.lobby.profile.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   
   public class ProfileUserVO extends DAAPIDataClass
   {
      
      private static const DOG_TAG_FIELD_NAME:String = "dogTag";
       
      
      public var name:String = "";
      
      public var registrationDate:String = "";
      
      public var lastBattleDate:String = "";
      
      public var userID:String = "";
      
      public var dogTag:DogTagVO = null;
      
      public function ProfileUserVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == DOG_TAG_FIELD_NAME)
         {
            this.dogTag = new DogTagVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.dogTag != null)
         {
            this.dogTag.dispose();
            this.dogTag = null;
         }
         super.onDispose();
      }
   }
}

package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalMissionsAbstractInfoViewVO extends DAAPIDataClass
   {
       
      
      public var bgSource:String = "";
      
      public var titleLabel:String = "";
      
      public var subtitleLabel:String = "";
      
      public var bigBtnLabel:String = "";
      
      public function PersonalMissionsAbstractInfoViewVO(param1:Object = null)
      {
         super(param1);
      }
   }
}

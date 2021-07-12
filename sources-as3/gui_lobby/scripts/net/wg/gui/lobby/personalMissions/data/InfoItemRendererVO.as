package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class InfoItemRendererVO extends DAAPIDataClass
   {
       
      
      public var index:int = -1;
      
      public var iconSource:String = "";
      
      public var titleLabel:String = "";
      
      public var descriptionLabel:String = "";
      
      public function InfoItemRendererVO(param1:Object)
      {
         super(param1);
      }
   }
}

package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class InfoItemRendererVO extends DAAPIDataClass
   {
       
      
      public var iconSource:String = "";
      
      public var titleLabel:String = "";
      
      public var descriptionLabel:String = "";
      
      public var showDelay:int = -1;
      
      public function InfoItemRendererVO(param1:Object)
      {
         super(param1);
      }
   }
}

package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VPEventProgressionBuyingPanelVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var shortTitle:String = "";
      
      public var money:String = "";
      
      public var price:String = "";
      
      public var priceTooltip:String = "";
      
      public var buyButtonEnabled:Boolean = false;
      
      public var buyButtonLabel:String = "";
      
      public var buyButtonTooltip:String = "";
      
      public function VPEventProgressionBuyingPanelVO(param1:Object)
      {
         super(param1);
      }
   }
}

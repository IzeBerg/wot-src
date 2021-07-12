package net.wg.gui.lobby.techtree.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ResearchRootVO extends DAAPIDataClass
   {
       
      
      public var tankTierStr:String = "";
      
      public var tankNameStr:String = "";
      
      public var tankTierStrSmall:String = "";
      
      public var tankNameStrSmall:String = "";
      
      public var typeIconPath:String = "";
      
      public var shopIconPath:String = "";
      
      public var isInteractive:Boolean = true;
      
      public var buttonLabel:String = "";
      
      public var blueprintLabel:String = "";
      
      public var blueprintProgress:Number = 0;
      
      public var blueprintCanConvert:Boolean = false;
      
      public var bpbGlowEnabled:Boolean = false;
      
      public var itemPrices:Array = null;
      
      public var compareBtnVisible:Boolean = true;
      
      public var compareBtnEnabled:Boolean = false;
      
      public var compareBtnLabel:String = "";
      
      public var compareBtnTooltip:String = "";
      
      public var previewBtnEnabled:Boolean = false;
      
      public var previewBtnLabel:String = "";
      
      public var isElite:Boolean = false;
      
      public var statusStr:String = "";
      
      public var discountStr:String = "";
      
      public var rentBtnLabel:String = "";
      
      public var changeNationBtnVisibility:Boolean = false;
      
      public var isTankNationChangeAvailable:Boolean = false;
      
      public var nationChangeIsNew:Boolean = false;
      
      public var nationChangeTooltip:String = "";
      
      public var roleText:String = "";
      
      public function ResearchRootVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.itemPrices != null)
         {
            this.itemPrices.splice(0,this.itemPrices.length);
            this.itemPrices = null;
         }
         super.onDispose();
      }
   }
}

package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PremiumEarningsVO extends DAAPIDataClass
   {
      
      public static const XP_TITLE_STR:String = "xpTitleStrings";
      
      public static const XP_TITLE_TOOLTIP:String = "xpTitleTooltips";
       
      
      public var xpTitleStrings:Vector.<String>;
      
      public var xpTitleTooltips:Vector.<String>;
      
      public var xpPremValues:Array = null;
      
      public var xpNoPremValues:Array = null;
      
      public var creditsPremValues:Array = null;
      
      public var creditsNoPremValues:Array = null;
      
      public var backgroundIcon:String = "";
      
      public function PremiumEarningsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == XP_TITLE_STR)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
            this.fillXpTitleStrings(_loc3_);
            return false;
         }
         if(param1 == XP_TITLE_TOOLTIP)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
            this.fillXpTitleTooltips(_loc3_);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.xpTitleStrings)
         {
            this.xpTitleStrings.splice(0,this.xpTitleStrings.length);
            this.xpTitleStrings = null;
         }
         if(this.xpTitleTooltips)
         {
            this.xpTitleTooltips.splice(0,this.xpTitleTooltips.length);
            this.xpTitleTooltips = null;
         }
         if(this.xpPremValues != null)
         {
            this.xpPremValues.splice(0,this.xpPremValues.length);
            this.xpPremValues = null;
         }
         if(this.xpNoPremValues != null)
         {
            this.xpNoPremValues.splice(0,this.xpNoPremValues.length);
            this.xpNoPremValues = null;
         }
         if(this.creditsPremValues != null)
         {
            this.creditsPremValues.splice(0);
            this.creditsPremValues = null;
         }
         if(this.creditsNoPremValues != null)
         {
            this.creditsNoPremValues.splice(0);
            this.creditsNoPremValues = null;
         }
         super.onDispose();
      }
      
      private function fillXpTitleStrings(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = param1.length;
            this.xpTitleStrings = new Vector.<String>(_loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.xpTitleStrings[_loc3_] = param1[_loc3_];
               _loc3_++;
            }
         }
      }
      
      private function fillXpTitleTooltips(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = param1.length;
            this.xpTitleTooltips = new Vector.<String>(_loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.xpTitleTooltips[_loc3_] = param1[_loc3_];
               _loc3_++;
            }
         }
      }
   }
}

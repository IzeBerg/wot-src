package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedBattlesUnreachableViewVO extends DAAPIDataClass
   {
      
      private static const FIELD_BOTTOM_RULES:String = "bottomRules";
      
      private static const FIELD_HEADER:String = "header";
       
      
      public var closeBtnLabel:String = "";
      
      public var closeBtnTooltip:String = "";
      
      public var bgImage:String = "";
      
      public var centerImg:String = "";
      
      public var centerImgBig:String = "";
      
      public var centerText:String = "";
      
      public var bottomText:String = "";
      
      public var bottomRules:Vector.<RuleVO> = null;
      
      public var header:RankedBattlesPageHeaderVO = null;
      
      public function RankedBattlesUnreachableViewVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.bottomRules)
         {
            _loc1_ = this.bottomRules.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.bottomRules[_loc2_].dispose();
               _loc2_++;
            }
            this.bottomRules.splice(0,_loc1_);
            this.bottomRules = null;
         }
         if(this.header != null)
         {
            this.header.dispose();
            this.header = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == FIELD_BOTTOM_RULES)
         {
            this.bottomRules = new Vector.<RuleVO>();
            _loc3_ = param2 as Array;
            for each(_loc4_ in _loc3_)
            {
               this.bottomRules.push(new RuleVO(_loc4_));
            }
            return false;
         }
         if(param1 == FIELD_HEADER)
         {
            this.header = new RankedBattlesPageHeaderVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}

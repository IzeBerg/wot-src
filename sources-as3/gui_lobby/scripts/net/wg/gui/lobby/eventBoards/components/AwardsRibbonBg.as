package net.wg.gui.lobby.eventBoards.components
{
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class AwardsRibbonBg extends UIComponentEx
   {
      
      private static const RANK_GOLD:int = 1;
      
      private static const RANK_SILVER:int = 2;
      
      private static const RANK_BRONZE:int = 3;
      
      private static const RANK_IRON:int = 4;
      
      private static const RANK_WOODEN:int = 5;
      
      private static const RANK_HIGH_LABEL:String = "rankHigh";
      
      private static const RANK_MEDIUM_LABEL:String = "rankMedium";
      
      private static const RANK_LOW_LABEL:String = "rankLow";
      
      private static const RANK_IRON_LABEL:String = "rankIron";
      
      private static const RANK_WOODEN_LABEL:String = "rankWooden";
       
      
      private var _bgId:int = -1;
      
      public function AwardsRibbonBg()
      {
         super();
         visible = false;
      }
      
      override protected function draw() : void
      {
         if(this._bgId != Values.DEFAULT_INT && isInvalid(InvalidationType.DATA))
         {
            switch(this._bgId)
            {
               case RANK_GOLD:
                  gotoAndStop(RANK_HIGH_LABEL);
                  break;
               case RANK_SILVER:
                  gotoAndStop(RANK_MEDIUM_LABEL);
                  break;
               case RANK_BRONZE:
                  gotoAndStop(RANK_LOW_LABEL);
                  break;
               case RANK_IRON:
                  gotoAndStop(RANK_IRON_LABEL);
                  break;
               case RANK_WOODEN:
                  gotoAndStop(RANK_WOODEN_LABEL);
            }
            visible = true;
         }
         super.draw();
      }
      
      public function setBackground(param1:int) : void
      {
         this._bgId = param1;
         invalidateData();
      }
   }
}

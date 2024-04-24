package net.wg.gui.lobby.rankedBattles19.components.stats
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsInfoVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedBattleStatsInfo extends RankedBattleStats
   {
      
      private static const LABEL_Y_OFFSET:int = -6;
      
      private static const INFO_Y_OFFSET:int = 1;
       
      
      public var info:Sprite = null;
      
      private var _data:RankedBattlesStatsInfoVO = null;
      
      public function RankedBattleStatsInfo()
      {
         super();
      }
      
      override public function setData(param1:RankedBattlesStatsVO) : void
      {
         this._data = RankedBattlesStatsInfoVO(param1);
         super.setData(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         labelYOffset = LABEL_Y_OFFSET;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.info.x = labelTf.x + labelTf.width;
               this.info.y = labelTf.y + INFO_Y_OFFSET;
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.info = null;
         this._data = null;
         super.onDispose();
      }
   }
}

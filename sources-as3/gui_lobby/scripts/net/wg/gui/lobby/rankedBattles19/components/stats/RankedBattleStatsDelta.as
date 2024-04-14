package net.wg.gui.lobby.rankedBattles19.components.stats
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsDeltaVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedBattleStatsDelta extends RankedBattleStats
   {
      
      private static const LABEL_Y_OFFSET:int = -6;
      
      private static const DELTA_Y_OFFSET:int = -1;
      
      private static const DELTA_X_OFFSET:int = -1;
       
      
      public var deltaTf:TextField = null;
      
      private var _data:RankedBattlesStatsDeltaVO = null;
      
      public function RankedBattleStatsDelta()
      {
         super();
      }
      
      override public function setData(param1:RankedBattlesStatsVO) : void
      {
         this._data = RankedBattlesStatsDeltaVO(param1);
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
            if(isInvalid(InvalidationType.DATA))
            {
               this.deltaTf.visible = StringUtils.isNotEmpty(this._data.delta);
               if(this.deltaTf.visible)
               {
                  this.deltaTf.htmlText = this._data.delta;
                  App.utils.commons.updateTextFieldSize(this.deltaTf);
               }
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.layoutDelta();
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.deltaTf = null;
         this._data = null;
         super.onDispose();
      }
      
      public function layoutDelta() : void
      {
         this.deltaTf.x = valueTf.x + valueTf.width + DELTA_X_OFFSET;
         this.deltaTf.y = valueTf.y + DELTA_Y_OFFSET;
      }
   }
}

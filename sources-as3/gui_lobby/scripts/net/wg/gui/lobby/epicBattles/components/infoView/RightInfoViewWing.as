package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoCombatReservesVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class RightInfoViewWing extends UIComponentEx
   {
      
      private static const SMALL_SCALE:Number = 0.8;
      
      private static const REGULAR_SCALE:Number = 1;
      
      private static const SMALL_X_OFFSET:int = 210;
      
      private static const REGULAR_X_OFFSET:int = 240;
       
      
      public var combatReservesPanel:CombatReservesElement = null;
      
      public var background:MovieClip = null;
      
      private var _isSmallMode:Boolean = false;
      
      public function RightInfoViewWing()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._isSmallMode)
            {
               this.background.scaleX = this.background.scaleY = SMALL_SCALE;
               this.combatReservesPanel.x = SMALL_X_OFFSET;
            }
            else
            {
               this.background.scaleX = this.background.scaleY = REGULAR_SCALE;
               this.combatReservesPanel.x = REGULAR_X_OFFSET;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.combatReservesPanel.dispose();
         this.combatReservesPanel = null;
         this.background = null;
         super.onDispose();
      }
      
      public function setData(param1:EpicBattlesInfoCombatReservesVO) : void
      {
         this.combatReservesPanel.setData(param1);
      }
      
      public function set isSmallMode(param1:Boolean) : void
      {
         this._isSmallMode = param1;
         invalidateSize();
      }
   }
}

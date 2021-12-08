package net.wg.gui.battle.eventBattle.views.radialMenu
{
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.EventContent;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.IconRotationContainer;
   import net.wg.gui.battle.views.radialMenu.RadialButton;
   
   public class EventRadialButton extends RadialButton
   {
       
      
      public var bg:BattleAtlasSprite = null;
      
      public var eventContent:EventContent = null;
      
      public var iconsUp:IconRotationContainer = null;
      
      public var iconsHover:IconRotationContainer = null;
      
      private var _disabledButton:Boolean;
      
      public function EventRadialButton()
      {
         super();
      }
      
      public function setRadialState(param1:String) : void
      {
      }
      
      public function setDisabledButton(param1:Boolean) : void
      {
      }
      
      public function setChatState(param1:Boolean) : void
      {
      }
      
      protected function initComponents() : void
      {
      }
      
      protected function showIcon(param1:String) : void
      {
      }
      
      protected function drawAngle() : void
      {
      }
      
      protected function drawText() : void
      {
      }
      
      override protected function onDispose() : void
      {
      }
      
      public function get disabledButton() : Boolean
      {
         return this._disabledButton;
      }
   }
}

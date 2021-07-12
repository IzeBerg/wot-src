package net.wg.gui.battle.eventBattle.views.radialMenu
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.battle.eventBattle.views.radialMenu.components.RadialPaging;
   import net.wg.gui.battle.views.radialMenu.RadialButton;
   import net.wg.infrastructure.base.meta.IEventRadialMenuMeta;
   import net.wg.infrastructure.base.meta.impl.EventRadialMenuMeta;
   import scaleform.clik.motion.Tween;
   
   public class EventRadialMenu extends EventRadialMenuMeta implements IEventRadialMenuMeta
   {
      
      public static const DEFAULT_STATE:String = "default";
      
      public static const ALLY_STATE:String = "ally";
      
      public static const ENEMY_STATE:String = "enemy";
      
      private static const DEFAULT_SCALE:Number = 1;
      
      private static const CHANGE_ANIMATION_SCALE:Number = 0.9;
      
      private static const EVENT_BACK_ALPHA:Number = 0.45;
      
      private static const TWEEN_HALF_TIME:Number = 100;
      
      private static const EVENT_OFFSET_ANGLE:Number = 45;
      
      private static const EVENT_FIRST_ANGLE:Number = 225;
      
      private static const EVENT_POINT_RADIUS:int = 200;
      
      private static const EVENT_INTERNAL_MENU_RADIUS:int = 185;
      
      private static const ONE_PAGE:int = 1;
       
      
      public var chatTitleTF:TextField = null;
      
      public var alliesTF:TextField = null;
      
      public var allyNameTF:TextField = null;
      
      public var enemyNameTF:TextField = null;
      
      public var paging:RadialPaging = null;
      
      public var middleBtn:RadialButton = null;
      
      private var _targetDisplayName:String = null;
      
      private var _pageTween:Tween = null;
      
      private var _pageTweenObj:Object;
      
      private var _currentPage:int = 0;
      
      private var _pageCount:int = 0;
      
      private var _isInAnimation:Boolean = false;
      
      public function EventRadialMenu()
      {
         this._pageTweenObj = {"scale":DEFAULT_SCALE};
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      protected function getButtons() : Vector.<RadialButton>
      {
         return null;
      }
      
      protected function getButtonData(param1:Array, param2:uint) : Object
      {
         return null;
      }
      
      override protected function showWithName(param1:String, param2:Array, param3:Array, param4:String) : void
      {
      }
      
      protected function configBG() : void
      {
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
      
      protected function updateData() : void
      {
      }
      
      protected function updateButton(param1:RadialButton, param2:Object) : void
      {
      }
      
      protected function selectButton(param1:RadialButton) : void
      {
      }
      
      protected function unSelectButton(param1:RadialButton) : void
      {
      }
      
      protected function cancelButton(param1:RadialButton) : void
      {
      }
      
      protected function internalShow() : void
      {
      }
      
      protected function internalHide() : void
      {
      }
      
      protected function updateButtons() : void
      {
      }
      
      protected function action() : void
      {
      }
      
      protected function onHideFromSchedule() : void
      {
      }
      
      private function hideTextAndPage() : void
      {
      }
      
      private function nextPage() : void
      {
      }
      
      private function nextPageFadeIn() : void
      {
      }
      
      private function nextPageComplete() : void
      {
      }
      
      private function pageFadeUpdate() : void
      {
      }
      
      private function setButtonsScale(param1:Number) : void
      {
      }
      
      private function disposePageTween() : void
      {
      }
      
      private function isDisabledButton(param1:RadialButton) : Boolean
      {
         return false;
      }
      
      protected function onButtonMouseDown(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseMove(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseWheel(param1:MouseEvent) : void
      {
      }
   }
}

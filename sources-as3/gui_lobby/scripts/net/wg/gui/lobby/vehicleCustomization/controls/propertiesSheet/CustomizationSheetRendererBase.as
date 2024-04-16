package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationSheetRendererBase extends UIComponentEx
   {
       
      
      public var iconsAnimatedContainer:CustomizationSheetIconAnimated = null;
      
      public var emptyHitMc:Sprite = null;
      
      public var hitMc:Sprite = null;
      
      private var _currentAction:int = -1;
      
      protected var currentLayoutId:int = -1;
      
      protected var animatedTransition:Boolean = false;
      
      protected var isActionTheSame:Boolean = false;
      
      protected var layoutIdApplied:Boolean = false;
      
      public function CustomizationSheetRendererBase()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.emptyHitMc = new Sprite();
         addChild(this.emptyHitMc);
         hitArea = this.emptyHitMc;
         mouseEnabled = mouseChildren = false;
         this.setInitState();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.hitMc = null;
         this.emptyHitMc = null;
         this.iconsAnimatedContainer.dispose();
         this.iconsAnimatedContainer = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         this.isActionTheSame = this._currentAction == param1.actionType;
         this._currentAction = param1.actionType;
         this.iconsAnimatedContainer.setData(param1,this.isActionTheSame,this.animatedTransition);
         invalidateData();
      }
      
      public function setLayout(param1:int) : void
      {
         if(this.currentLayoutId == param1)
         {
            return;
         }
         this.currentLayoutId = param1;
         gotoAndStop(this.currentLayoutId);
         this.applyLayoutId();
      }
      
      protected function applyLayoutId() : void
      {
         this.layoutIdApplied = true;
      }
      
      public function set isAnimatedTransition(param1:Boolean) : void
      {
         this.animatedTransition = param1;
      }
      
      public function setInitState() : void
      {
         this.iconsAnimatedContainer.switchIcon(false);
      }
      
      public function onOverHandler() : void
      {
         this.iconsAnimatedContainer.switchIcon(true);
      }
      
      public function onOutHandler() : void
      {
         this.iconsAnimatedContainer.switchIcon(false);
      }
      
      public function onClickHandler() : void
      {
      }
      
      protected function onDisabledOnMouseOver() : void
      {
      }
      
      protected function onEnabledOnMouseOver() : void
      {
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 != super.enabled && hitTestPoint(stage.mouseX,stage.mouseY))
         {
            if(param1)
            {
               this.onEnabledOnMouseOver();
            }
            else
            {
               this.onDisabledOnMouseOver();
            }
         }
         super.enabled = param1;
         this.iconsAnimatedContainer.enabled = param1;
         this.iconsAnimatedContainer.switchIcon(false);
      }
      
      public function get actionType() : int
      {
         return this._currentAction;
      }
   }
}

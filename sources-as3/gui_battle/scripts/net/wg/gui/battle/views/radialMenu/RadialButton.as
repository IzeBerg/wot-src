package net.wg.gui.battle.views.radialMenu
{
   import flash.display.Sprite;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.RADIAL_MENU_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.radialMenu.components.Content;
   import net.wg.gui.battle.views.radialMenu.components.Icons;
   import net.wg.gui.battle.views.radialMenu.components.SectorHoveredWrapper;
   import net.wg.gui.battle.views.radialMenu.components.SectorWrapper;
   
   public class RadialButton extends BattleUIComponent
   {
      
      private static const TITLE_TEXT_FIELD_X_OFFSET:int = 40;
      
      private static const KEY_TEXT_FIELD_X_OFFSET:int = -64;
      
      private static const CUSTOM_ICON_FIELD_X_OFFSET:int = -54;
      
      private static const ANGLE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const TITLE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const KEY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      private static const VISUAL_STATE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 5;
      
      private static const DEFAULT_NONE_KEY:String = "";
      
      private static const ARROW_TEXT:String = "Arrow";
      
      private static const LEFT_MOUSE_BUTTON:String = "LMB";
      
      private static const RIGHT_MOUSE_BUTTON:String = "RMB";
      
      private static const MIDDLE_MOUSE_BUTTON:String = "MMB";
      
      private static const ADDITIONAL_MOUSE_BUTTON_UP:String = "UP_MB";
      
      private static const ADDITIONAL_MOUSE_BUTTON_DOWN:String = "DOWN_MB";
      
      private static const ADDITIONAL_MOUSE_BUTTON_MB6:String = "MB6";
      
      private static const ADDITIONAL_MOUSE_BUTTON_MB7:String = "MB7";
      
      private static const LEFT_ARROW_BUTTON:String = "Left Arrow";
      
      private static const RIGHT_ARROW_BUTTON:String = "Right Arrow";
      
      private static const DOWN_ARROW_BUTTON:String = "Down Arrow";
      
      private static const UP_ARROW_BUTTON:String = "Up Arrow";
      
      private static const SECTOR_WRAPPER_FRAME_FADEIN:String = "fadeIn";
      
      private static const SECTOR_WRAPPER_FRAME_FADEOUT:String = "fadeOut";
      
      private static const BUTTONS_WITH_CUSTOM_ICON:Vector.<String> = new <String>[LEFT_MOUSE_BUTTON,RIGHT_MOUSE_BUTTON,MIDDLE_MOUSE_BUTTON,ADDITIONAL_MOUSE_BUTTON_UP,ADDITIONAL_MOUSE_BUTTON_DOWN,ADDITIONAL_MOUSE_BUTTON_MB6,ADDITIONAL_MOUSE_BUTTON_MB7,LEFT_ARROW_BUTTON,RIGHT_ARROW_BUTTON,DOWN_ARROW_BUTTON,UP_ARROW_BUTTON];
       
      
      public var idx:int = -1;
      
      public var action:String = "";
      
      public var selected:Boolean = false;
      
      public var sectorWrapper:SectorWrapper = null;
      
      public var content:Content = null;
      
      public var icons:Icons = null;
      
      public var hitAreaSpr:Sprite = null;
      
      public var sectorWrapperHovered:SectorHoveredWrapper = null;
      
      public var contentHovered:Content = null;
      
      public var iconsHovered:Icons = null;
      
      private var _angle:Number = 0;
      
      private var _titleStr:String = "";
      
      private var _titleColor:String = "";
      
      private var _keyStr:String = "";
      
      private var _currentState:String = "";
      
      private var _buttonVisualState:String = "";
      
      private var _hasButtonCustomIcon:Boolean = false;
      
      public function RadialButton()
      {
         super();
         this.content = this.sectorWrapper.content;
         this.icons = this.content.icons;
         this.contentHovered = this.sectorWrapperHovered.content;
         this.iconsHovered = this.contentHovered.icons;
         this.hitAreaSpr = this.sectorWrapper.hitAreaSpr;
         this.hitAreaSpr.visible = false;
      }
      
      public function setTitle(param1:String, param2:String) : void
      {
         if(this._titleStr != param1)
         {
            this._titleStr = param1;
            this._titleColor = param2;
            invalidate(TITLE_VALIDATION);
         }
      }
      
      public function set icon(param1:String) : void
      {
         this.showIcon(param1);
      }
      
      public function set hotKey(param1:String) : void
      {
         if(this._keyStr != param1)
         {
            this._keyStr = param1;
            this._hasButtonCustomIcon = BUTTONS_WITH_CUSTOM_ICON.indexOf(param1) >= 0 && param1 != DEFAULT_NONE_KEY;
            invalidate(KEY_VALIDATION);
         }
      }
      
      public function set buttonVisualState(param1:String) : void
      {
         if(param1 != this._buttonVisualState)
         {
            this._buttonVisualState = param1;
            invalidate(VISUAL_STATE_VALIDATION);
         }
      }
      
      public function get buttonVisualState() : String
      {
         return this._buttonVisualState;
      }
      
      private function showIcon(param1:String) : void
      {
         this.icons.showIcon(param1);
         this.iconsHovered.showIcon(param1);
      }
      
      public function set angle(param1:Number) : void
      {
         if(this._angle != param1)
         {
            this._angle = param1;
            invalidate(ANGLE_VALIDATION);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(ANGLE_VALIDATION))
         {
            this.rotation = this._angle;
            this.content.rotation = -this._angle;
            this.contentHovered.rotation = -this._angle;
         }
         if(isInvalid(TITLE_VALIDATION))
         {
            this.content.animateAndSetTitle(this._titleStr,this._titleColor);
            this.contentHovered.animateAndSetTitle(this._titleStr,this._titleColor);
            if(this.rotation < 0)
            {
               _loc1_ = this._keyStr.indexOf(ARROW_TEXT) >= 0 ? int(KEY_TEXT_FIELD_X_OFFSET) : int(CUSTOM_ICON_FIELD_X_OFFSET);
               this.content.setContentsXCoord(TITLE_TEXT_FIELD_X_OFFSET,KEY_TEXT_FIELD_X_OFFSET,_loc1_);
               this.contentHovered.setContentsXCoord(TITLE_TEXT_FIELD_X_OFFSET,KEY_TEXT_FIELD_X_OFFSET,_loc1_);
            }
         }
         if(isInvalid(KEY_VALIDATION))
         {
            if(this._hasButtonCustomIcon)
            {
               this.content.customButtonIcon.gotoAndStop(this._keyStr);
               this.contentHovered.customButtonIcon.gotoAndStop(this._keyStr);
            }
            else
            {
               this.content.setKeyTextAndBackgroundWidth(this._keyStr);
               this.contentHovered.setKeyTextAndBackgroundWidth(this._keyStr);
            }
            if(this.rotation < 0)
            {
               _loc1_ = this._keyStr.indexOf(ARROW_TEXT) >= 0 ? int(KEY_TEXT_FIELD_X_OFFSET) : int(CUSTOM_ICON_FIELD_X_OFFSET);
               this.content.setKeyXCoord(KEY_TEXT_FIELD_X_OFFSET,_loc1_);
               this.contentHovered.setKeyXCoord(KEY_TEXT_FIELD_X_OFFSET,_loc1_);
            }
            this.updateKeyVisibility();
         }
         if(isInvalid(VISUAL_STATE_VALIDATION))
         {
            this.content.icons.visible = this.content.titleMC.visible = this.contentHovered.icons.visible = this.contentHovered.titleMC.visible = this._buttonVisualState == RADIAL_MENU_CONSTS.NORMAL_BUTTON_STATE;
            this.updateKeyVisibility();
         }
      }
      
      public function set state(param1:String) : void
      {
         if(this._buttonVisualState == RADIAL_MENU_CONSTS.EMPTY_BUTTON_STATE || this._buttonVisualState == RADIAL_MENU_CONSTS.DISABLED_BUTTON_STATE)
         {
            return;
         }
         if(this._currentState != param1)
         {
            this._currentState = param1;
            if(param1 == InteractiveStates.OVER)
            {
               this.sectorWrapperHovered.light.gotoAndPlay(SECTOR_WRAPPER_FRAME_FADEIN);
            }
            else if(param1 == InteractiveStates.OUT)
            {
               this.sectorWrapperHovered.light.gotoAndPlay(SECTOR_WRAPPER_FRAME_FADEOUT);
            }
            gotoAndPlay(param1);
         }
      }
      
      public function set iconState(param1:String) : void
      {
         this.icons.setState(param1);
         this.iconsHovered.setState(param1);
         this.sectorWrapperHovered.setLightState(param1);
      }
      
      private function updateKeyVisibility() : void
      {
         var _loc1_:Boolean = this._buttonVisualState == RADIAL_MENU_CONSTS.NORMAL_BUTTON_STATE;
         var _loc2_:Boolean = this._keyStr != DEFAULT_NONE_KEY && _loc1_;
         var _loc3_:Boolean = _loc2_ && !this._hasButtonCustomIcon;
         this.content.setKeyVisibility(_loc3_);
         this.contentHovered.setKeyVisibility(_loc3_);
         this.content.customButtonIcon.visible = this.contentHovered.customButtonIcon.visible = _loc2_ && this._hasButtonCustomIcon;
      }
      
      override protected function onDispose() : void
      {
         this.sectorWrapper.dispose();
         this.sectorWrapperHovered.dispose();
         this.sectorWrapper = null;
         this.sectorWrapperHovered = null;
         this.icons = null;
         this.iconsHovered = null;
         this.content = null;
         this.contentHovered = null;
         this.hitAreaSpr = null;
         super.onDispose();
      }
   }
}

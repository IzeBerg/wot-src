package net.wg.gui.lobby.settings
{
   import flash.display.BlendMode;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.gfx.TextFieldEx;
   
   public class DisabledTabsOverlay extends UIComponentEx
   {
      
      private static const BG_Y:uint = 27;
      
      private static const BG_HEIGHT:uint = 520;
      
      private static const DISABLE_COLOR:uint = 2105359;
      
      private static const DISABLE_ALPHA:Number = 0.6;
      
      private static const TAB_ROUND:Number = 3;
      
      private static const TABS_PROPERTY:String = "tabs";
       
      
      public var bg:Sprite = null;
      
      public var glow:Sprite = null;
      
      public var textField:TextField = null;
      
      private var _tabIndexes:Vector.<int> = null;
      
      private var _mainTabCovers:Vector.<Sprite>;
      
      private var _secondaryTabCovers:Vector.<Sprite>;
      
      private var _currentView:DisplayObjectContainer = null;
      
      private var _currentIndex:int = -1;
      
      public function DisabledTabsOverlay()
      {
         this._mainTabCovers = new Vector.<Sprite>(0);
         this._secondaryTabCovers = new Vector.<Sprite>(0);
         super();
      }
      
      private static function drawTabs(param1:ButtonBarEx, param2:Vector.<int>, param3:Vector.<Sprite>) : void
      {
         var _loc4_:Button = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Sprite = null;
         var _loc7_:Graphics = null;
         var _loc8_:uint = param1.dataProvider.length;
         var _loc9_:uint = 0;
         while(_loc9_ < _loc8_)
         {
            if(param2 == null || param2.indexOf(_loc9_) != -1)
            {
               _loc4_ = param1.getButtonAt(_loc9_);
               _loc5_ = _loc4_.getBounds(_loc4_.parent);
               _loc6_ = new Sprite();
               _loc6_.x = _loc5_.x;
               _loc6_.y = _loc5_.y;
               _loc7_ = _loc6_.graphics;
               _loc7_.beginFill(DISABLE_COLOR,DISABLE_ALPHA);
               _loc7_.drawRoundRectComplex(0,0,_loc5_.width,_loc5_.height,TAB_ROUND,TAB_ROUND,0,0);
               _loc7_.endFill();
               _loc6_.mouseEnabled = false;
               _loc6_.blendMode = BlendMode.MULTIPLY;
               _loc4_.parent.addChildAt(_loc6_,_loc4_.parent.getChildIndex(_loc4_) + 1);
               param3.push(_loc6_);
            }
            _loc9_++;
         }
      }
      
      private static function clearTabCovers(param1:Vector.<Sprite>) : void
      {
         var _loc2_:Sprite = null;
         while(param1.length > 0)
         {
            _loc2_ = param1.pop();
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setNoTranslate(this.textField,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:ButtonBarEx = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._currentView != null)
            {
               clearTabCovers(this._secondaryTabCovers);
               _loc1_ = 0;
               _loc2_ = this._tabIndexes.indexOf(this._currentIndex) != -1;
               if(_loc2_ && this._currentView.hasOwnProperty(TABS_PROPERTY))
               {
                  _loc3_ = this._currentView[TABS_PROPERTY];
                  if(_loc3_.y == 0)
                  {
                     _loc3_.validateNow();
                     drawTabs(_loc3_,null,this._secondaryTabCovers);
                     if(this._secondaryTabCovers.length > 0)
                     {
                        _loc1_ = this._secondaryTabCovers[0].height;
                     }
                  }
               }
               this.bg.visible = this.glow.visible = this.textField.visible = _loc2_;
               if(_loc2_)
               {
                  this.bg.y = BG_Y + _loc1_;
                  this.bg.height = BG_HEIGHT - _loc1_;
               }
            }
         }
      }
      
      public function setupTabs(param1:ButtonBarEx, param2:Vector.<int>, param3:String) : void
      {
         drawTabs(param1,param2,this._mainTabCovers);
         this._tabIndexes = param2;
         this.textField.text = param3;
      }
      
      public function updateDisabledView(param1:DisplayObjectContainer, param2:int) : void
      {
         this._currentView = param1;
         this._currentIndex = param2;
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         clearTabCovers(this._mainTabCovers);
         clearTabCovers(this._secondaryTabCovers);
         this._mainTabCovers = null;
         this._secondaryTabCovers = null;
         this.bg = null;
         this.glow = null;
         this.textField = null;
         this._tabIndexes = null;
         this._currentView = null;
         super.onDispose();
      }
   }
}

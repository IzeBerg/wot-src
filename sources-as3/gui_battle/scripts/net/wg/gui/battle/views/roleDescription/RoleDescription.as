package net.wg.gui.battle.views.roleDescription
{
   import fl.motion.easing.Quartic;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.views.roleDescription.data.RoleActionVO;
   import net.wg.gui.battle.views.roleDescription.data.RoleDescriptionVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.meta.IRoleDescriptionMeta;
   import net.wg.infrastructure.base.meta.impl.RoleDescriptionMeta;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.motion.Tween;
   
   public class RoleDescription extends RoleDescriptionMeta implements IRoleDescriptionMeta
   {
      
      private static const DESCRIPTION_Y_OFFSET:int = -8;
      
      private static const MSG_Y_OFFSET:int = 10;
      
      private static const ROLE_ACTION_Y_OFFSET:int = 5;
      
      private static const SEPARATOR_X_OFFSET:int = 5;
      
      private static const SEPARATOR_Y_OFFSET:int = 3;
      
      private static const FADE_TWEEN_DURATION:uint = 1500;
      
      private static const FADE_IN_ALPHA:Number = 1;
      
      private static const FADE_OUT_ALPHA:Number = 0;
      
      private static const ROLE_ACTION_LINKAGE:String = "RoleActionUI";
       
      
      public var image:Image = null;
      
      public var description:TextField = null;
      
      public var msg:TextField = null;
      
      public var separatorLeft:Sprite = null;
      
      public var separatorRight:Sprite = null;
      
      public var shadowBg:Sprite = null;
      
      private var _data:RoleDescriptionVO = null;
      
      private var _renderers:Vector.<RoleAction>;
      
      private var _classFactory:IClassFactory;
      
      private var _fadeTween:Tween = null;
      
      private var _bottomBorderY:int = 0;
      
      private var _isVisible:Boolean = false;
      
      private var _isLocked:Boolean = false;
      
      private var _isHidden:Boolean = false;
      
      public function RoleDescription()
      {
         this._renderers = new Vector.<RoleAction>(0);
         this._classFactory = App.utils.classFactory;
         super();
         visible = false;
         blendMode = BlendMode.SCREEN;
         this.shadowBg.blendMode = BlendMode.MULTIPLY;
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         this._isLocked = !param1 || this._isHidden;
         super.setCompVisible(param1 && this._isVisible && !this._isHidden);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.description.autoSize = TextFieldAutoSize.CENTER;
         this.msg.autoSize = TextFieldAutoSize.CENTER;
         this.msg.text = INGAME_HELP.ROLEDESCRIPTION_MSG;
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Vector.<RoleActionVO> = null;
         var _loc2_:RoleAction = null;
         var _loc3_:RoleActionVO = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:RoleAction = null;
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.image.source = this._data.roleIcon;
               this.description.htmlText = this._data.roleDescription;
               this.clearRenderers();
               _loc1_ = this._data.roleActions;
               for each(_loc3_ in _loc1_)
               {
                  _loc2_ = this._classFactory.getComponent(ROLE_ACTION_LINKAGE,RoleAction);
                  addChild(_loc2_);
                  this._renderers.push(_loc2_);
                  _loc2_.setData(_loc3_);
               }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc4_ = (this.description.width >> 1) * -1 | 0;
               _loc5_ = this.image.height + DESCRIPTION_Y_OFFSET | 0;
               _loc6_ = _loc5_ + this.msg.height + MSG_Y_OFFSET;
               this.description.x = _loc4_;
               this.description.y = _loc5_;
               this.separatorLeft.x = _loc4_ - this.separatorLeft.width - SEPARATOR_X_OFFSET;
               this.separatorRight.x = _loc4_ + this.description.width + SEPARATOR_X_OFFSET;
               this.separatorRight.y = this.separatorLeft.y = _loc5_ + (this.description.height - this.separatorLeft.height >> 1) + SEPARATOR_Y_OFFSET | 0;
               this.msg.x = -this.msg.width >> 1;
               this.msg.y = _loc6_;
               this.image.x = -this.image.width >> 1;
               _loc7_ = -Math.round(RoleAction.WIDTH * this._renderers.length >> 1) + (RoleAction.WIDTH >> 1);
               _loc8_ = _loc6_ + ROLE_ACTION_Y_OFFSET;
               for each(_loc9_ in this._renderers)
               {
                  _loc9_.x = _loc7_;
                  _loc9_.y = _loc8_;
                  _loc7_ += RoleAction.WIDTH;
               }
               if(_loc9_)
               {
                  this._bottomBorderY = _loc8_ + RoleAction.HEIGHT;
               }
               else
               {
                  this._bottomBorderY = _loc6_ + this.msg.height;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this.clearRenderers();
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         this.description = null;
         this.msg = null;
         this.separatorLeft = null;
         this.separatorRight = null;
         this.shadowBg = null;
         this._data = null;
         this._renderers = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      override protected function setData(param1:RoleDescriptionVO) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         if(this._isVisible != param1)
         {
            this._isVisible = param1;
            if(!this._isLocked)
            {
               this.showFadeTween();
            }
            else if(!this._isVisible)
            {
               this.hide();
            }
         }
      }
      
      private function hide() : void
      {
         this.setCompVisible(false);
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function clearTween() : void
      {
         if(this._fadeTween)
         {
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
      }
      
      private function clearRenderers() : void
      {
         var _loc1_:RoleAction = null;
         for each(_loc1_ in this._renderers)
         {
            removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._renderers.length = 0;
      }
      
      private function showFadeTween() : void
      {
         if(this._isVisible)
         {
            alpha = FADE_OUT_ALPHA;
            this.setCompVisible(true);
         }
         this._fadeTween = new Tween(FADE_TWEEN_DURATION,this,{"alpha":(!!this._isVisible ? FADE_IN_ALPHA : FADE_OUT_ALPHA)},{
            "paused":false,
            "ease":Quartic.easeOut,
            "fastTransform":false,
            "onComplete":(!!this._isVisible ? null : this.hide)
         });
      }
      
      public function get isHidden() : Boolean
      {
         return this._isHidden;
      }
      
      public function set isHidden(param1:Boolean) : void
      {
         if(this._isHidden != param1)
         {
            this._isHidden = param1;
            this.setCompVisible(!this._isHidden);
         }
      }
      
      public function get bottomBorderY() : int
      {
         return this._bottomBorderY;
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}

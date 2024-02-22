package net.wg.gui.login.impl.components
{
   import fl.transitions.easing.Strong;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.gui.login.IRssNewsFeedRenderer;
   import net.wg.gui.login.impl.vo.RssItemVo;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.base.meta.IRssNewsFeedMeta;
   import net.wg.infrastructure.base.meta.impl.RssNewsFeedMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Padding;
   
   public class RssNewsFeed extends RssNewsFeedMeta implements IRssNewsFeedMeta
   {
       
      
      public var container:Sprite = null;
      
      public var bg:Sprite = null;
      
      private var rssItems:Vector.<RssNewsFeedRenderer> = null;
      
      private var rssItemsVo:Vector.<RssItemVo> = null;
      
      private const MARGIN_BETWEEN_ITEMS:Number = 13;
      
      private const RENDERER_CLASS_REFERENCE:String = "RssNewsFeedRendererUI";
      
      private var _padding:Padding;
      
      private var moveTween:Tween = null;
      
      private var tweenManager:ExcludeTweenManager;
      
      public function RssNewsFeed()
      {
         this._padding = new Padding(10,20,40,7);
         this.tweenManager = new ExcludeTweenManager();
         super();
         this.rssItems = new Vector.<RssNewsFeedRenderer>();
         this.rssItemsVo = new Vector.<RssItemVo>();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bg.height = 0;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:IRssNewsFeedRenderer = null;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = null;
            _loc4_ = this.rssItemsVo.length;
            _loc5_ = false;
            _loc1_ = 0;
            while(_loc1_ < _loc4_)
            {
               _loc5_ = false;
               _loc2_ = 0;
               while(_loc2_ < this.rssItems.length)
               {
                  _loc3_ = this.rssItems[_loc2_];
                  if(this.rssItemsVo[_loc1_].id == _loc3_.itemId)
                  {
                     _loc5_ = true;
                     _loc3_.setData(this.rssItemsVo[_loc1_]);
                     break;
                  }
                  _loc2_++;
               }
               if(!_loc5_)
               {
                  _loc3_ = this.addRenderer(this.rssItemsVo[_loc1_]);
                  this.rssItems.push(_loc3_);
               }
               _loc1_++;
            }
            if(this.rssItems.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.rssItems.length)
               {
                  _loc3_ = this.rssItems[_loc1_];
                  _loc6_ = _loc3_.itemId;
                  _loc5_ = false;
                  _loc2_ = 0;
                  while(_loc2_ < this.rssItemsVo.length)
                  {
                     if(this.rssItemsVo[_loc2_].id == _loc6_)
                     {
                        _loc5_ = true;
                        break;
                     }
                     _loc2_++;
                  }
                  if(!_loc5_)
                  {
                     this.rssItems.splice(_loc1_,1);
                     this.preRemoveRenderer(_loc3_);
                  }
                  else
                  {
                     _loc1_++;
                  }
               }
            }
            this.updateRenderersPositions();
         }
         this.updateBG();
      }
      
      private function updateRenderersPositions() : void
      {
         var _loc1_:Number = this.rssItems.length;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:IRssNewsFeedRenderer = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:Number = this._padding.bottom;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = this.rssItems[_loc2_];
            if(_loc4_.isUsed)
            {
               _loc5_ = _loc4_ as DisplayObject;
               App.utils.asserter.assertNotNull(_loc5_,"displayObj" + Errors.CANT_NULL);
               this.container.setChildIndex(_loc5_,_loc3_);
               _loc6_ += _loc4_.itemHeight;
               _loc4_.moveToY(-_loc6_);
               _loc4_.x = 0;
               _loc6_ += this.MARGIN_BETWEEN_ITEMS;
               _loc3_++;
            }
            _loc2_++;
         }
         this.container.x = this._padding.left;
      }
      
      private function updateBG() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:IRssNewsFeedRenderer = null;
         if(this.container && this.container.numChildren)
         {
            _loc1_ = false;
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = this.container.numChildren;
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = null;
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc7_ = this.container.getChildAt(_loc5_) as IRssNewsFeedRenderer;
               App.utils.asserter.assertNotNull(_loc7_,"renderer" + Errors.CANT_NULL);
               if(_loc7_.isUsed)
               {
                  _loc1_ = true;
                  _loc2_ += _loc7_.itemHeight + this.MARGIN_BETWEEN_ITEMS;
               }
               _loc3_ = Math.max(_loc3_,_loc7_.itemWidth);
               _loc5_++;
            }
            if(_loc1_)
            {
               _loc2_ = Math.round(_loc2_ + this._padding.vertical - this.MARGIN_BETWEEN_ITEMS);
            }
            else
            {
               _loc2_ = 0;
            }
            this.moveTween = this.tweenManager.registerAndLaunch(RssNewsFeedRenderer.MOOVING_ANIMATION_SPEED,this.bg,{"height":_loc2_},{
               "ease":Strong.easeInOut,
               "onComplete":this.onMoveTweenComplete
            });
            this.moveTween.fastTransform = false;
            this.bg.width = this.container.x + _loc3_ + this._padding.right;
         }
         if(this.bg.height == 0)
         {
            this.bg.height = 1;
         }
         dispatchEvent(new RssItemEvent(RssItemEvent.ITEM_SIZE_INVALID));
      }
      
      private function onMoveTweenComplete(param1:Tween) : void
      {
         this.tweenManager.unregister(param1);
      }
      
      private function addRenderer(param1:RssItemVo) : IRssNewsFeedRenderer
      {
         var _loc2_:Class = App.utils.classFactory.getClass(this.RENDERER_CLASS_REFERENCE);
         var _loc3_:IRssNewsFeedRenderer = new _loc2_() as IRssNewsFeedRenderer;
         App.utils.asserter.assertNotNull(_loc3_,"renderer" + Errors.CANT_NULL);
         var _loc4_:DisplayObject = _loc3_ as DisplayObject;
         App.utils.asserter.assertNotNull(_loc4_,"displayObj" + Errors.CANT_NULL);
         _loc3_.y = 0;
         _loc3_.alpha = 0;
         this.container.addChild(_loc4_);
         this.setupRenderer(_loc3_,param1);
         return _loc3_;
      }
      
      private function setupRenderer(param1:IRssNewsFeedRenderer, param2:RssItemVo) : void
      {
         param1.setData(param2);
         param1.validateNow();
         param1.addEventListener(RssItemEvent.TO_REED_MORE,this.toBrowser);
         param1.addEventListener(RssItemEvent.ITEM_SIZE_INVALID,this.onRendererSizeInvalid);
         param1.addEventListener(RssItemEvent.ON_HIDED,this.onRendererHided);
      }
      
      private function onRendererSizeInvalid(param1:RssItemEvent) : void
      {
         this.updateRenderersPositions();
         this.updateBG();
      }
      
      private function cleanRenderer(param1:IRssNewsFeedRenderer) : void
      {
         param1.removeEventListener(RssItemEvent.TO_REED_MORE,this.toBrowser);
         param1.removeEventListener(RssItemEvent.ITEM_SIZE_INVALID,this.onRendererSizeInvalid);
         param1.removeEventListener(RssItemEvent.ON_HIDED,this.onRendererHided);
      }
      
      private function onRendererHided(param1:RssItemEvent) : void
      {
         this.removeRenderer(IRssNewsFeedRenderer(param1.currentTarget));
      }
      
      private function toBrowser(param1:RssItemEvent) : void
      {
         openBrowserS(param1.rssVo.link);
      }
      
      private function preRemoveRenderer(param1:IRssNewsFeedRenderer) : void
      {
         param1.hide();
      }
      
      private function removeRenderer(param1:IRssNewsFeedRenderer) : void
      {
         this.container.removeChild(DisplayObject(param1));
         this.cleanRenderer(param1);
         param1.dispose();
         param1 = null;
      }
      
      override protected function onDispose() : void
      {
         if(this.tweenManager)
         {
            this.tweenManager.dispose();
            this.tweenManager = null;
         }
         if(this.moveTween)
         {
            this.moveTween = null;
         }
         this.rssItemsVo = null;
         var _loc1_:RssNewsFeedRenderer = null;
         while(this.rssItems.length > 0)
         {
            _loc1_ = this.rssItems.pop();
            this.removeRenderer(_loc1_);
         }
         super.onDispose();
      }
      
      override protected function updateFeed(param1:Vector.<RssItemVo>) : void
      {
         this.rssItemsVo = param1;
         invalidateData();
      }
   }
}

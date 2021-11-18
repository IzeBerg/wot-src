package net.wg.gui.lobby.manualChapter.controls
{
   import flash.geom.Point;
   import net.wg.gui.lobby.manualChapter.data.ManualChapterHintsVO;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.constants.InvalidationType;
   
   public class HintsContainer extends PageContentTemplate
   {
       
      
      public var item1:HintRenderer;
      
      public var item2:HintRenderer;
      
      public var item3:HintRenderer;
      
      public var item4:HintRenderer;
      
      public var item5:HintRenderer;
      
      private var _vo:ManualChapterHintsVO = null;
      
      private var _positions:Vector.<Point>;
      
      private var _renderers:Vector.<HintRenderer>;
      
      private const ITEM:String = "item";
      
      private const HINT:String = "hint";
      
      private const HINT_VERTICAL_PADDING:Number = 30;
      
      private const MULTI_ROW_LENGTH:int = 5;
      
      private const SEC_ROW_RENDERER:int = 2;
      
      public function HintsContainer()
      {
         this._positions = new Vector.<Point>();
         this._renderers = new Vector.<HintRenderer>();
         super();
      }
      
      override public function isCentered() : Boolean
      {
         return this._vo && this._vo.hints.length >= this.MULTI_ROW_LENGTH;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._vo = ManualChapterHintsVO(getData());
         var _loc2_:String = this.HINT + String(this._vo.hints.length);
         if(currentFrameLabel != _loc2_)
         {
            this.disposeRenderers();
            gotoAndStop(_loc2_);
            this.setRenderers();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!this._renderers.length)
         {
            this.setRenderers();
         }
      }
      
      override protected function draw() : void
      {
         var _loc3_:HintRenderer = null;
         var _loc4_:Boolean = false;
         super.draw();
         var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
         var _loc2_:Boolean = isInvalid(InvalidationType.DATA);
         if(isInvalid(InvalidationType.STATE))
         {
            _loc4_ = isFadingIn();
            for each(_loc3_ in this._renderers)
            {
               if(_loc4_)
               {
                  _loc3_.fadeIn();
               }
               else
               {
                  _loc3_.fadeOut();
               }
            }
         }
         if(_loc1_ || _loc2_)
         {
            this.updateScaleLayout();
            if(_loc2_)
            {
               this.updateData();
            }
            for each(_loc3_ in this._renderers)
            {
               _loc3_.validateNow();
            }
            this.updateLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeRenderers();
         this._renderers = null;
         this._positions = null;
         this.item1 = null;
         this.item2 = null;
         this.item3 = null;
         this.item4 = null;
         this.item5 = null;
         this._vo = null;
         super.onDispose();
      }
      
      override protected function getDataVO(param1:Object) : IDAAPIDataClass
      {
         return new ManualChapterHintsVO(param1);
      }
      
      private function disposeRenderers() : void
      {
         var _loc1_:HintRenderer = null;
         for each(_loc1_ in this._renderers)
         {
            _loc1_.dispose();
         }
         this._renderers.splice(0,this._renderers.length);
         this._positions.splice(0,this._positions.length);
      }
      
      private function setRenderers() : void
      {
         var _loc3_:HintRenderer = null;
         var _loc1_:int = numChildren - 1;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this[this.ITEM + (_loc2_ + 1).toString()];
            this._renderers.push(_loc3_);
            this._positions.push(new Point(_loc3_.x,_loc3_.y));
            _loc2_++;
         }
      }
      
      private function updateData() : void
      {
         var _loc3_:HintRenderer = null;
         var _loc1_:int = this._renderers.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._renderers[_loc2_];
            _loc3_.setData(this._vo.hints[_loc2_]);
            _loc2_++;
         }
      }
      
      private function updateScaleLayout() : void
      {
         var _loc1_:Number = NaN;
         var _loc4_:HintRenderer = null;
         _loc1_ = getContentScale();
         var _loc2_:int = this._renderers.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._renderers[_loc3_];
            _loc4_.updateScaleFactor(_loc1_);
            _loc4_.x = this._positions[_loc3_].x * _loc1_;
            _loc4_.y = this._positions[_loc3_].y * _loc1_;
            _loc3_++;
         }
      }
      
      private function updateLayout() : void
      {
         var _loc3_:HintRenderer = null;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc1_:int = this._renderers.length;
         var _loc2_:uint = 0;
         if(_loc1_ == this.MULTI_ROW_LENGTH)
         {
            _loc4_ = getContentScale();
            _loc5_ = 0;
            while(_loc5_ < this.SEC_ROW_RENDERER)
            {
               _loc2_ = Math.max(this._renderers[_loc5_].height,_loc2_);
               _loc5_++;
            }
            while(_loc5_ < _loc1_)
            {
               this._renderers[_loc5_].y = this._renderers[_loc5_].y + _loc2_ + this.HINT_VERTICAL_PADDING * _loc4_;
               _loc5_++;
            }
         }
         _loc2_ = 0;
         for each(_loc3_ in this._renderers)
         {
            _loc2_ = Math.max(_loc3_.y + _loc3_.height,_loc2_);
         }
         height = _loc2_;
      }
   }
}

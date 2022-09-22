package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.inblocks.data.BlueprintBlockVO;
   import net.wg.gui.components.tooltips.inblocks.data.ImageBlockVO;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IScheduler;
   
   public class BlueprintBlock extends ImageBlock
   {
      
      private static const BLUEPRINT_OFFSET:Number = 35;
      
      private static const LOADING_TF_OFFSET:Number = 20;
      
      private static const EMPTY_POINT:Point = new Point(0,0);
      
      private static const RELOAD_BP_DELAY:int = 500;
       
      
      public var blueprintLoader:UILoaderAlt = null;
      
      public var loadingTf:TextField = null;
      
      private var _data:BlueprintBlockVO = null;
      
      private var _blueprintMask:Shape = null;
      
      private var _testBlueprintPnt:Point;
      
      private var _testBlueprintPntScaled:Boolean = false;
      
      private var _needBlueprintImageTesting:Boolean = false;
      
      private var _scheduler:IScheduler = null;
      
      private var _asserter:IAssertable = null;
      
      public function BlueprintBlock()
      {
         this._testBlueprintPnt = new Point();
         super();
         this._blueprintMask = new Shape();
         addChild(this._blueprintMask);
         this.loadingTf.text = TOOLTIPS.BLUEPRINT_VEHICLEBLUEPRINTTOOLTIP_LOADING;
         App.utils.commons.updateTextFieldSize(this.loadingTf);
         this.blueprintLoader.addEventListener(UILoaderEvent.COMPLETE,this.onBlueprintLoaderCompleteHandler);
         this._scheduler = App.utils.scheduler;
         this._asserter = App.utils.asserter;
      }
      
      override public function cleanUp() : void
      {
         this._scheduler.cancelTask(this.reloadBlueprintImage);
         this.clearData();
         this.blueprintLoader.mask = null;
         this._blueprintMask.graphics.clear();
         this.blueprintLoader.unload();
         this.blueprintLoader.alpha = 1;
         super.cleanUp();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         super.setBlockData(param1);
         this._data = BlueprintBlockVO(this.data);
      }
      
      override protected function createData(param1:Object) : ImageBlockVO
      {
         return new BlueprintBlockVO(param1);
      }
      
      override protected function onDispose() : void
      {
         this.cleanUp();
         this.blueprintLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onBlueprintLoaderCompleteHandler);
         removeChild(this._blueprintMask);
         this._blueprintMask = null;
         this.blueprintLoader.dispose();
         this.blueprintLoader = null;
         this.loadingTf = null;
         this._scheduler = null;
         this._asserter = null;
         this._testBlueprintPnt = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         var _loc1_:Boolean = super.onValidateBlock();
         if(_loc1_)
         {
            this.applyBlueprintData();
         }
         return _loc1_;
      }
      
      override protected function layout() : void
      {
         super.layout();
         this.blueprintLoader.x = this._blueprintMask.x = imageLoader.x + BLUEPRINT_OFFSET;
         this.blueprintLoader.y = this._blueprintMask.y = imageLoader.y + BLUEPRINT_OFFSET;
         this.loadingTf.x = imageLoader.x + (imageLoader.width - this.loadingTf.width >> 1);
         this.loadingTf.y = imageLoader.y + (imageLoader.height - this.loadingTf.height >> 1) + LOADING_TF_OFFSET;
      }
      
      private function applyBlueprintData() : void
      {
         this.blueprintLoader.source = this._data.blueprintPath;
         this.blueprintLoader.autoSize = true;
         this.blueprintLoader.maintainAspectRatio = false;
         this.blueprintLoader.width = imageLoader.width - BLUEPRINT_OFFSET * 2;
         this.blueprintLoader.height = imageLoader.height - BLUEPRINT_OFFSET * 2;
         this.blueprintLoader.alpha = this._data.alpha;
         this.applyMask();
      }
      
      private function testBlueprintImage(param1:Bitmap) : void
      {
         var _loc2_:BitmapData = param1.bitmapData;
         if(!_loc2_.hitTest(EMPTY_POINT,0,this._testBlueprintPnt))
         {
            this._scheduler.scheduleTask(this.reloadBlueprintImage,RELOAD_BP_DELAY);
         }
         else
         {
            this.loadingTf.visible = false;
            this._needBlueprintImageTesting = false;
         }
      }
      
      private function reloadBlueprintImage() : void
      {
         this.blueprintLoader.unload();
         this.blueprintLoader.source = this._data.blueprintPath;
      }
      
      private function applyMask() : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc1_:Array = this._data.blueprintLayout;
         this._asserter.assert(this._data.numCols > 0,"numCols " + Errors.WRONG_VALUE);
         this._asserter.assert(this._data.numRows > 0,"numRows " + Errors.WRONG_VALUE);
         this._asserter.assert(_loc1_ != null,"blueprintLayout " + Errors.CANT_NULL);
         this._asserter.assert(_loc1_.length == this._data.numRows * this._data.numCols,"blueprintLayout " + Errors.WRONG_VALUE);
         var _loc2_:Number = this.blueprintLoader.width / this._data.numCols;
         var _loc3_:Number = this.blueprintLoader.height / this._data.numRows;
         var _loc4_:Graphics = this._blueprintMask.graphics;
         var _loc7_:uint = 0;
         var _loc8_:Boolean = false;
         var _loc9_:int = _loc1_.length;
         _loc4_.clear();
         _loc4_.beginFill(16777215);
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_)
         {
            if(!_loc1_[_loc10_])
            {
               _loc7_++;
            }
            else
            {
               _loc5_ = _loc10_ % this._data.numCols * _loc2_;
               _loc6_ = Math.floor(_loc10_ / this._data.numCols) * _loc3_;
               _loc4_.drawRect(_loc5_,_loc6_,_loc2_,_loc3_);
               if(!_loc8_)
               {
                  this._testBlueprintPnt.x = _loc5_ + (_loc2_ >> 1);
                  this._testBlueprintPnt.y = _loc6_ + (_loc3_ >> 1);
                  _loc8_ = true;
               }
            }
            _loc10_++;
         }
         _loc4_.endFill();
         this.blueprintLoader.mask = this._blueprintMask;
         this.blueprintLoader.visible = this.loadingTf.visible = _loc7_ != _loc1_.length;
         this._testBlueprintPntScaled = false;
         this._needBlueprintImageTesting = _loc7_ > 0 && this.loadingTf.visible;
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      private function onBlueprintLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:Number = NaN;
         if(this._needBlueprintImageTesting && stage != null)
         {
            _loc2_ = Bitmap(this.blueprintLoader.content);
            if(!this._testBlueprintPntScaled)
            {
               _loc3_ = _loc2_.width / this.blueprintLoader.width;
               this._testBlueprintPnt.x *= _loc3_;
               this._testBlueprintPnt.y *= _loc3_;
               this._testBlueprintPntScaled = true;
            }
            this.testBlueprintImage(_loc2_);
         }
      }
   }
}

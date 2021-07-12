package net.wg.gui.components.advanced
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.interfaces.IComplexProgressStepRenderer;
   import net.wg.gui.components.advanced.vo.ComplexProgressIndicatorVO;
   import net.wg.gui.components.controls.StatusIndicatorEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ComplexProgressIndicator extends UIComponentEx
   {
       
      
      public var progressBar:StatusIndicatorEx = null;
      
      public var container:Sprite = null;
      
      public var textField:TextField = null;
      
      private var _model:ComplexProgressIndicatorVO = null;
      
      public function ComplexProgressIndicator()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.progressBar.minimum = 0;
         this.progressBar.maximum = 1;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._model)
         {
            this.progressBar.value = this._model.progress;
            this.textField.htmlText = this._model.text;
            this.redrawSteps();
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearSteps();
         this.progressBar.dispose();
         this.progressBar = null;
         this.container = null;
         this.textField = null;
         this._model = null;
         super.onDispose();
      }
      
      private function redrawSteps() : void
      {
         var _loc1_:IComplexProgressStepRenderer = null;
         this.clearSteps();
         var _loc2_:uint = this._model.steps.length;
         var _loc3_:Number = this.progressBar.lineWidth / _loc2_;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = App.utils.classFactory.getComponent(this._model.rendererClassLinkage,IComplexProgressStepRenderer);
            _loc1_.x = (_loc4_ + 1) * _loc3_ + this.progressBar.lineStart | 0;
            _loc1_.showLine = _loc4_ < _loc2_ - 1;
            _loc1_.setData(this._model.steps[_loc4_]);
            this.container.addChild(DisplayObject(_loc1_));
            _loc4_++;
         }
         _loc1_.x = this.progressBar.lineWidth + this.progressBar.lineStart;
      }
      
      private function clearSteps() : void
      {
         var _loc1_:IComplexProgressStepRenderer = null;
         while(this.container.numChildren)
         {
            _loc1_ = IComplexProgressStepRenderer(this.container.getChildAt(0));
            this.container.removeChild(DisplayObject(_loc1_));
            _loc1_.dispose();
         }
      }
      
      public function get model() : ComplexProgressIndicatorVO
      {
         return this._model;
      }
      
      public function set model(param1:ComplexProgressIndicatorVO) : void
      {
         this._model = param1;
         invalidateData();
      }
   }
}

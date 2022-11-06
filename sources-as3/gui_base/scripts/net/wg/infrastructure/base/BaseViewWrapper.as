package net.wg.infrastructure.base
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.IAbstractWrapperView;
   import net.wg.infrastructure.interfaces.IBaseLayout;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InvalidationType;
   
   public class BaseViewWrapper extends UIComponentEx implements IWrapper
   {
       
      
      private var _content:IAbstractWrapperView;
      
      protected var _layout:IBaseLayout;
      
      public function BaseViewWrapper()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            if(this._layout && this._content)
            {
               this.invokeLayout();
            }
         }
      }
      
      protected function invokeLayout() : void
      {
         this._layout.invokeLayout();
      }
      
      public function get wrapperContent() : IAbstractWrapperView
      {
         return this._content;
      }
      
      public function set wrapperContent(param1:IAbstractWrapperView) : void
      {
         var _loc2_:DisplayObject = null;
         if(this._content != param1)
         {
            _loc2_ = DisplayObject(this._content);
            if(_loc2_)
            {
               if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               this._content = null;
            }
            this._content = param1;
            _loc2_ = DisplayObject(this._content);
            addChild(_loc2_);
            invalidateLayout();
         }
      }
      
      public function get layout() : IBaseLayout
      {
         return this._layout;
      }
      
      public function set layout(param1:IBaseLayout) : void
      {
         if(this._layout != param1)
         {
            if(this._layout)
            {
               this._layout.dispose();
            }
            this._layout = param1;
            if(this._layout)
            {
               this._layout.target = this;
            }
            invalidateLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this._content = null;
         if(this._layout)
         {
            this._layout.dispose();
         }
         super.onDispose();
      }
      
      public function get isModal() : Boolean
      {
         return false;
      }
      
      public function get modalAlpha() : Number
      {
         return Values.DEFAULT_ALPHA;
      }
      
      public function get window() : IManagedContent
      {
         return this;
      }
      
      public function get sourceView() : IView
      {
         return this._content;
      }
      
      public function get containerContent() : IManagedContent
      {
         return this;
      }
   }
}

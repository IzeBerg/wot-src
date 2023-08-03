package net.wg.gui.components.controls.helpers
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.TextLoading;
   
   public class TextFieldLoadingContainer
   {
       
      
      protected var _textField:TextField = null;
      
      protected var _loading:TextLoading = null;
      
      protected var _initialTFAlpha:Number = 1.0;
      
      protected var _htmlText:String = "";
      
      private var _isUserNameSetFromProps:Boolean = false;
      
      private var _loadingStyle:String = "loadingStyleNone";
      
      public function TextFieldLoadingContainer(param1:String)
      {
         super();
         this._loadingStyle = param1;
      }
      
      public function dispose() : void
      {
         this._htmlText = Values.EMPTY_STR;
         if(this._textField != null)
         {
            this._textField.alpha = this._initialTFAlpha;
            if(this._loading != null)
            {
               this._textField.x = this._loading.x;
               this._textField.y = this._loading.y;
            }
            this._textField = null;
         }
         if(this._loading != null)
         {
            if(this._loading.parent != null)
            {
               this._loading.parent.removeChild(this._loading);
            }
            this._loading.dispose();
            this._loading = null;
         }
      }
      
      public function hide() : void
      {
         if(this._loading != null)
         {
            this._loading.visible = false;
         }
         if(this._textField != null)
         {
            this._textField.alpha = 0;
         }
      }
      
      public function isLoading() : Boolean
      {
         if(this._loading != null)
         {
            return this._loadingStyle == this._loading.getLoadingStyle();
         }
         return false;
      }
      
      public function setControlledTextField(param1:TextField) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(this._loading == null || this._textField != param1)
         {
            if(this._loading != null)
            {
               this.dispose();
            }
            this._loading = App.utils.classFactory.getComponent(Linkages.TEXT_LOADING_UI,TextLoading);
            if(param1 != null && param1.parent != null)
            {
               this._initialTFAlpha = param1.alpha;
               param1.alpha = 0;
               _loc2_ = param1.parent.getChildIndex(param1);
               this._loading.x = param1.x;
               this._loading.y = param1.y;
               param1.parent.addChildAt(this._loading,_loc2_ + 1);
            }
         }
         if(this._loading != null)
         {
            this._loading.setLoadingStyle(this._loadingStyle);
         }
         this._textField = param1;
         this.setTextFieldIsLoading(true);
      }
      
      public function setHtmlText(param1:String) : void
      {
         if(this._htmlText != param1)
         {
            this.setTextFieldIsLoading(true);
         }
         this._htmlText = param1;
         if(this._textField != null)
         {
            this._textField.htmlText = param1;
         }
      }
      
      public function setTextFieldIsLoading(param1:Boolean) : void
      {
         if(this._textField != null)
         {
            if(param1)
            {
               if(this._textField.alpha != 0)
               {
                  this._initialTFAlpha = this._textField.alpha;
                  this._textField.alpha = 0;
               }
            }
            else
            {
               this._textField.alpha = this._initialTFAlpha;
               if(this._loading != null)
               {
                  this._textField.x = this._loading.x;
                  this._textField.y = this._loading.y;
                  this._textField.dispatchEvent(new Event(Event.CHANGE));
               }
            }
         }
         if(this._loading != null)
         {
            this._loading.setLoadingStyle(!!param1 ? this._loadingStyle : TextLoadingStyle.LOADING_STYLE_NONE);
         }
      }
      
      public function show() : void
      {
         if(this._loading != null)
         {
            if(this.isLoading())
            {
               this._loading.visible = true;
            }
            else if(this._textField != null)
            {
               this._textField.alpha = this._initialTFAlpha;
               this._textField.x = this._loading.x;
               this._textField.y = this._loading.y;
            }
         }
      }
      
      public function get isUserNameSetFromProps() : Boolean
      {
         return this._isUserNameSetFromProps;
      }
      
      public function set isUserNameSetFromProps(param1:Boolean) : void
      {
         this._isUserNameSetFromProps = param1;
      }
   }
}

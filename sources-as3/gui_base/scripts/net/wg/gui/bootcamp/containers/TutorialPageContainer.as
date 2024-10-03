package net.wg.gui.bootcamp.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialPageContainer extends Sprite implements IDisposable
   {
      
      private static const TEXT_Y_OFFSET:int = 14;
       
      
      public var txtHeader1:TextField;
      
      public var txtHeader2:TextField;
      
      public var txtHeader3:TextField;
      
      public var txtHeader4:TextField;
      
      public var txtHeader5:TextField;
      
      public var txtDescription1:TextField;
      
      public var htmlDescription1:TextField;
      
      public var txtDescription2:TextField;
      
      public var txtDescription3:TextField;
      
      public var txtDescription4:TextField;
      
      public var txtTitle1:TextField;
      
      public var txtTitle2:TextField;
      
      public var txtTitle3:TextField;
      
      public var txtHeader2Blind:TextField;
      
      public var loader:UILoaderAlt;
      
      public var loaderBlind:UILoaderAlt;
      
      private var _loaderWidth:int = 0;
      
      private var _loaderHeight:int = 0;
      
      private var _disposed:Boolean = false;
      
      private var _isAdaptable:Boolean = false;
      
      public function TutorialPageContainer()
      {
         super();
      }
      
      public function addLoaderListener() : void
      {
         this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onBackgroundCompleteHandler,false,0,true);
      }
      
      public function removeLoaderListener() : void
      {
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onBackgroundCompleteHandler);
      }
      
      public function setLoaderSize(param1:int, param2:int) : void
      {
         this._loaderWidth = param1;
         this._loaderHeight = param2;
      }
      
      private function onBackgroundCompleteHandler(param1:UILoaderEvent) : void
      {
         this.loader.width = this._loaderWidth;
         this.loader.height = this._loaderHeight;
      }
      
      public function setData(param1:BCTutorialPageVO) : void
      {
         var _loc2_:IColorScheme = App.colorSchemeMgr.getScheme(ColorSchemeNames.RED_PURPLE_SCHEMA);
         if(this.loader)
         {
            this.loader.source = param1.background;
         }
         if(this.loaderBlind)
         {
            this.loaderBlind.source = param1.backgroundBlind;
            this.loaderBlind.transform.colorTransform = _loc2_.colorTransform;
         }
         if(this.txtHeader1)
         {
            this.txtHeader1.text = param1.header1Text;
            this.txtHeader1.autoSize = param1.header1AutoSize;
         }
         if(this.txtHeader2)
         {
            this.txtHeader2.text = param1.header2Text;
            this.txtHeader2.autoSize = param1.header2AutoSize;
         }
         if(this.txtHeader2Blind)
         {
            this.txtHeader2Blind.textColor = _loc2_.rgb;
            this.txtHeader2Blind.text = param1.header2Text;
            this.txtHeader2Blind.autoSize = param1.header2AutoSize;
         }
         if(this.txtHeader3)
         {
            this.txtHeader3.text = param1.header3Text;
            this.txtHeader3.autoSize = param1.header3AutoSize;
         }
         if(this.txtHeader4)
         {
            this.txtHeader4.text = param1.header4Text;
            this.txtHeader4.autoSize = param1.header4AutoSize;
         }
         if(this.txtHeader5)
         {
            this.txtHeader5.text = param1.header5Text;
            this.txtHeader5.autoSize = param1.header5AutoSize;
         }
         if(this.txtDescription1)
         {
            this.txtDescription1.text = param1.description1Text;
            this.txtDescription1.autoSize = param1.description1AutoSize;
         }
         if(this.htmlDescription1)
         {
            this.htmlDescription1.htmlText = param1.description1HtmlText;
            this.htmlDescription1.autoSize = param1.description1AutoSize;
         }
         if(this.txtDescription2)
         {
            this.txtDescription2.text = param1.description2Text;
            this.txtDescription2.autoSize = param1.description2AutoSize;
         }
         if(this.txtDescription3)
         {
            this.txtDescription3.text = param1.description3Text;
            this.txtDescription3.autoSize = param1.description3AutoSize;
         }
         if(this.txtDescription4)
         {
            this.txtDescription4.text = param1.description4Text;
            this.txtDescription4.autoSize = param1.description4AutoSize;
         }
         if(this.txtTitle1)
         {
            this.txtTitle1.text = param1.title1Text;
            this.txtTitle1.autoSize = param1.title1AutoSize;
         }
         if(this.txtTitle2)
         {
            this.txtTitle2.text = param1.title2Text;
            this.txtTitle2.autoSize = param1.title2AutoSize;
         }
         if(this.txtTitle3)
         {
            this.txtTitle3.text = param1.title3Text;
            this.txtTitle3.autoSize = param1.title3AutoSize;
         }
      }
      
      public function setTextsY(param1:int, param2:int, param3:int) : void
      {
         if(this.txtHeader1)
         {
            this.txtHeader1.y = param1 - param2;
         }
         if(this.htmlDescription1)
         {
            this.htmlDescription1.y = param1 - param3;
         }
         if(this.txtDescription1)
         {
            this.txtDescription1.y = param1 - param3;
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this.txtHeader1)
         {
            this.txtHeader1 = null;
         }
         if(this.txtHeader2)
         {
            this.txtHeader2 = null;
         }
         if(this.txtHeader2Blind)
         {
            this.txtHeader2Blind = null;
         }
         if(this.txtHeader3)
         {
            this.txtHeader3 = null;
         }
         if(this.txtHeader4)
         {
            this.txtHeader4 = null;
         }
         if(this.txtHeader5)
         {
            this.txtHeader5 = null;
         }
         if(this.txtDescription1)
         {
            this.txtDescription1 = null;
         }
         if(this.htmlDescription1)
         {
            this.htmlDescription1 = null;
         }
         if(this.txtDescription2)
         {
            this.txtDescription2 = null;
         }
         if(this.txtDescription3)
         {
            this.txtDescription3 = null;
         }
         if(this.txtDescription4)
         {
            this.txtDescription4 = null;
         }
         if(this.txtTitle1)
         {
            this.txtTitle1 = null;
         }
         if(this.txtTitle2)
         {
            this.txtTitle2 = null;
         }
         if(this.txtTitle3)
         {
            this.txtTitle3 = null;
         }
         if(this.loaderBlind)
         {
            this.loaderBlind.dispose();
            this.loaderBlind = null;
         }
         if(this.loader)
         {
            this.loader.dispose();
            this.loader = null;
         }
      }
      
      public function updateTextPosition(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int = 14) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this._isAdaptable)
         {
            _loc8_ = param3 + param5;
            _loc9_ = param1 - (param5 << 1);
            if(this.txtHeader5)
            {
               this.txtHeader1.width = this.txtHeader2.width = this.txtHeader3.width = this.txtHeader4.width = this.txtHeader5.width = _loc9_;
               this.txtHeader1.x = this.txtHeader2.x = this.txtHeader3.x = this.txtHeader4.x = this.txtHeader5.x = _loc8_;
               this.txtHeader5.y = param2 - this.txtHeader5.height - param4 - param6 >> 0;
               this.txtHeader4.y = this.txtHeader5.y - param7 - this.txtHeader4.height >> 0;
               this.txtHeader3.y = this.txtHeader4.y - param7 - this.txtHeader3.height >> 0;
               this.txtHeader2.y = this.txtHeader3.y - param7 - this.txtHeader2.height >> 0;
               this.txtHeader1.y = this.txtHeader2.y - param7 - this.txtHeader1.height >> 0;
            }
            else if(this.txtHeader4)
            {
               this.txtHeader1.width = this.txtHeader2.width = this.txtHeader3.width = this.txtHeader4.width = _loc9_;
               this.txtHeader1.x = this.txtHeader2.x = this.txtHeader3.x = this.txtHeader4.x = _loc8_;
               this.txtHeader4.y = param2 - this.txtHeader4.height - param4 - param6 >> 0;
               this.txtHeader3.y = this.txtHeader4.y - param7 - this.txtHeader3.height >> 0;
               this.txtHeader2.y = this.txtHeader3.y - param7 - this.txtHeader2.height >> 0;
               this.txtHeader1.y = this.txtHeader2.y - param7 - this.txtHeader1.height >> 0;
            }
            else if(this.txtHeader3)
            {
               this.txtHeader1.width = this.txtHeader2.width = this.txtHeader3.width = _loc9_;
               this.txtHeader1.x = this.txtHeader2.x = this.txtHeader3.x = _loc8_;
               this.txtHeader3.y = param2 - this.txtHeader3.height - param4 - param6 >> 0;
               this.txtHeader2.y = this.txtHeader3.y - param7 - this.txtHeader2.height >> 0;
               this.txtHeader1.y = this.txtHeader2.y - param7 - this.txtHeader1.height >> 0;
            }
            else if(this.txtHeader2)
            {
               this.txtHeader1.width = this.txtHeader2.width = _loc9_;
               this.txtHeader1.x = this.txtHeader2.x = _loc8_;
               this.txtHeader2.y = param2 - this.txtHeader2.height - param4 - param6 >> 0;
               this.txtHeader1.y = this.txtHeader2.y - param7 - this.txtHeader1.height >> 0;
            }
            else if(this.txtHeader1)
            {
               this.txtHeader1.width = _loc9_;
               this.txtHeader1.x = _loc8_;
               this.txtHeader1.y = param2 - this.txtHeader1.height - param4 - param6 >> 0;
            }
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function set isAdaptable(param1:Boolean) : void
      {
         this._isAdaptable = param1;
      }
   }
}

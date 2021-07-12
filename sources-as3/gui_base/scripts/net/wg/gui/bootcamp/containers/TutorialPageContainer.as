package net.wg.gui.bootcamp.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialPageContainer extends Sprite implements IDisposable
   {
       
      
      public var txtHeader1:TextField;
      
      public var txtHeader2:TextField;
      
      public var txtHeader3:TextField;
      
      public var txtHeader4:TextField;
      
      public var txtDescription1:TextField;
      
      public var txtDescription2:TextField;
      
      public var txtDescription3:TextField;
      
      public var txtDescription4:TextField;
      
      public var txtTitle1:TextField;
      
      public var txtTitle2:TextField;
      
      public var txtTitle3:TextField;
      
      public var txtHeader2Blind:TextField;
      
      public var loader:UILoaderAlt;
      
      public var loaderBlind:UILoaderAlt;
      
      public function TutorialPageContainer()
      {
         super();
      }
      
      public function setData(param1:BCTutorialPageVO) : void
      {
         this.loader.source = param1.background;
         var _loc2_:IColorScheme = App.colorSchemeMgr.getScheme(ColorSchemeNames.RED_PURPLE_SCHEMA);
         if(this.loaderBlind)
         {
            this.loaderBlind.source = param1.backgroundBlind;
            this.loaderBlind.transform.colorTransform = _loc2_.colorTransform;
         }
         if(this.txtHeader1)
         {
            this.txtHeader1.text = param1.header1Text;
            this.txtHeader1.autoSize = param1.header1AutoSize;
            this.txtHeader1 = null;
         }
         if(this.txtHeader2)
         {
            this.txtHeader2.text = param1.header2Text;
            this.txtHeader2.autoSize = param1.header2AutoSize;
            this.txtHeader2 = null;
         }
         if(this.txtHeader2Blind)
         {
            this.txtHeader2Blind.textColor = _loc2_.rgb;
            this.txtHeader2Blind.text = param1.header2Text;
            this.txtHeader2Blind.autoSize = param1.header2AutoSize;
            this.txtHeader2Blind = null;
         }
         if(this.txtHeader3)
         {
            this.txtHeader3.text = param1.header3Text;
            this.txtHeader3.autoSize = param1.header3AutoSize;
            this.txtHeader3 = null;
         }
         if(this.txtHeader4)
         {
            this.txtHeader4.text = param1.header4Text;
            this.txtHeader4.autoSize = param1.header4AutoSize;
            this.txtHeader4 = null;
         }
         if(this.txtDescription1)
         {
            this.txtDescription1.text = param1.description1Text;
            this.txtDescription1.autoSize = param1.description1AutoSize;
            this.txtDescription1 = null;
         }
         if(this.txtDescription2)
         {
            this.txtDescription2.text = param1.description2Text;
            this.txtDescription2.autoSize = param1.description2AutoSize;
            this.txtDescription2 = null;
         }
         if(this.txtDescription3)
         {
            this.txtDescription3.text = param1.description3Text;
            this.txtDescription3.autoSize = param1.description3AutoSize;
            this.txtDescription3 = null;
         }
         if(this.txtDescription4)
         {
            this.txtDescription4.text = param1.description4Text;
            this.txtDescription4.autoSize = param1.description4AutoSize;
            this.txtDescription4 = null;
         }
         if(this.txtTitle1)
         {
            this.txtTitle1.text = param1.title1Text;
            this.txtTitle1.autoSize = param1.title1AutoSize;
            this.txtTitle1 = null;
         }
         if(this.txtTitle2)
         {
            this.txtTitle2.text = param1.title2Text;
            this.txtTitle2.autoSize = param1.title2AutoSize;
            this.txtTitle2 = null;
         }
         if(this.txtTitle3)
         {
            this.txtTitle3.text = param1.title3Text;
            this.txtTitle3.autoSize = param1.title3AutoSize;
            this.txtTitle3 = null;
         }
      }
      
      public final function dispose() : void
      {
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
         if(this.txtDescription1)
         {
            this.txtDescription1 = null;
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
         this.loader.dispose();
         this.loader = null;
      }
   }
}

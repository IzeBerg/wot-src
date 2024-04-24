package net.wg.gui.lobby.window
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.infrastructure.base.meta.IEpicPrimeTimeMeta;
   import net.wg.infrastructure.base.meta.impl.EpicPrimeTimeMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicPrimeTime extends EpicPrimeTimeMeta implements IEpicPrimeTimeMeta
   {
      
      private static const TITLE_TF_DEF_OFFSET:int = 70;
      
      private static const TITLE_TF_SMALL_OFFSET:int = 45;
      
      private static const BREAKPOINT_SMALL_WIDTH:int = 1366;
       
      
      public var titleTf:TextField = null;
      
      public var shadow:MovieClip = null;
      
      private var _titleText:String = null;
      
      private var _txtStyle:String = null;
      
      public function EpicPrimeTime()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.titleTf = null;
         this.shadow = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(StringUtils.isNotEmpty(this._titleText) && isInvalid(InvalidationType.SIZE))
         {
            this.titleTf.x = 0;
            this.titleTf.width = width;
            this.shadow.width = width;
            this.shadow.height = height;
            if(width <= BREAKPOINT_SMALL_WIDTH)
            {
               _loc1_ = TEXT_MANAGER_STYLES.HERO_TITLE;
               this.titleTf.y = TITLE_TF_SMALL_OFFSET;
            }
            else
            {
               _loc1_ = TEXT_MANAGER_STYLES.EPIC_TITLE;
               this.titleTf.y = TITLE_TF_DEF_OFFSET;
            }
            if(this._txtStyle != _loc1_)
            {
               this._txtStyle = _loc1_;
               this.titleTf.htmlText = App.textMgr.getTextStyleById(_loc1_,this._titleText);
            }
         }
      }
      
      public function as_setBackgroundSource(param1:String) : void
      {
         setBackground(param1);
      }
      
      public function as_setHeaderText(param1:String) : void
      {
         this._titleText = param1;
         invalidateSize();
      }
   }
}

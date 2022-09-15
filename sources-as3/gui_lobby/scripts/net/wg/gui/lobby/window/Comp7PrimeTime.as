package net.wg.gui.lobby.window
{
   import flash.text.TextField;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.infrastructure.base.meta.IComp7PrimeTimeMeta;
   import net.wg.infrastructure.base.meta.impl.Comp7PrimeTimeMeta;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class Comp7PrimeTime extends Comp7PrimeTimeMeta implements IComp7PrimeTimeMeta
   {
      
      private static const TITLE_TF_DEF_OFFSET:int = 70;
      
      private static const TITLE_TF_SMALL_OFFSET:int = 45;
       
      
      public var titleTf:TextField = null;
      
      private var _titleText:String = null;
      
      private var _txtStyle:String = null;
      
      public function Comp7PrimeTime()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.titleTf = null;
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
            if(width <= StageSizeBoundaries.WIDTH_1366)
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
         setBackground(param1,true);
      }
      
      public function as_setHeaderText(param1:String) : void
      {
         this._titleText = param1;
         invalidateSize();
      }
   }
}

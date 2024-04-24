package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.InteractiveSortingButton;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProfileSortingButton extends InteractiveSortingButton
   {
      
      private static const SHOW_SEPARATOR_WIDTH_OFFSET:int = -2;
      
      private static const BG_FRAME_SEPARATOR:String = "separator";
      
      private static const BG_FRAME_EMPTY:String = "empty";
      
      private static const LOADER_ALPHA_ENABLED:Number = 1;
      
      private static const LOADER_ALPHA_DISABLED:Number = 0.3;
       
      
      private var showSeparator:Boolean = true;
      
      public function ProfileSortingButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mcDescendingIcon.addEventListener(UILoaderEvent.COMPLETE,this.sortingIconLoadingCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         mcDescendingIcon.removeEventListener(UILoaderEvent.COMPLETE,this.sortingIconLoadingCompleteHandler);
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(upperBg)
            {
               upperBg.width = _width + (!!this.showSeparator ? SHOW_SEPARATOR_WIDTH_OFFSET : Values.ZERO);
               upperBg.height = _height;
            }
            mcAscendingIcon.x = Math.round((_width - mcAscendingIcon.width) / 2);
            mcDescendingIcon.x = Math.round((_width - mcDescendingIcon.width) / 2);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:NormalSortingBtnVO = null;
         super.data = param1;
         if(param1 is NormalSortingBtnVO)
         {
            _loc2_ = NormalSortingBtnVO(param1);
            this.showSeparator = _loc2_.showSeparator;
            bg.gotoAndStop(!!this.showSeparator ? BG_FRAME_SEPARATOR : BG_FRAME_EMPTY);
            if(_loc2_.label)
            {
               _label = _loc2_.label;
               invalidateData();
            }
            loader.visible = Boolean(_loc2_.iconSource);
            loader.alpha = !!_loc2_.enabled ? Number(LOADER_ALPHA_ENABLED) : Number(LOADER_ALPHA_DISABLED);
         }
      }
      
      override protected function sortingIconLoadingCompleteHandler(param1:UILoaderEvent) : void
      {
         var _loc2_:UILoaderAlt = UILoaderAlt(param1.target);
         if(param1.target == mcAscendingIcon)
         {
            _loc2_.y = Math.round(_height - _loc2_.height);
         }
         isSortIconLoadingCompete = true;
         invalidateSize();
      }
   }
}

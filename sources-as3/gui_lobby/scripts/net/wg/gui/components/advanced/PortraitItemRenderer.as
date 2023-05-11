package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundManagerStatesLobby;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.carousels.interfaces.ICarouselItemRenderer;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class PortraitItemRenderer extends SoundListItemRenderer implements ICarouselItemRenderer
   {
       
      
      public var loader:UILoaderAlt;
      
      public var emptyFocusIndicator:MovieClip;
      
      private var _canBeSelected:Boolean = true;
      
      public function PortraitItemRenderer()
      {
         super();
         useHandCursor = true;
         allowDeselect = false;
         toggle = true;
         preventAutosizing = true;
         constraintsDisabled = true;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         this.loader.source = RES_ICONS.maps_icons_tankmen_icons_barracks(param1.value);
      }
      
      override protected function onDispose() : void
      {
         if(this.loader)
         {
            this.loader.dispose();
            this.loader = null;
         }
         this.emptyFocusIndicator = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.emptyFocusIndicator)
         {
            focusIndicator = this.emptyFocusIndicator;
         }
         soundType = SoundTypes.CAROUSEL_BTN;
         soundId = SoundManagerStatesLobby.CAROUSEL_CELL_BTN;
      }
      
      public function get canBeSelected() : Boolean
      {
         return this._canBeSelected;
      }
      
      public function set canBeSelected(param1:Boolean) : void
      {
         this._canBeSelected = param1;
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(this._canBeSelected)
         {
            super.handleMouseRelease(param1);
         }
      }
   }
}

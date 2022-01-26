package net.wg.gui.lobby.hangar
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import scaleform.clik.constants.InvalidationType;
   
   public class LunarNYWidget extends GFInjectComponent
   {
      
      private static const BOUNDS:Object = {
         "small":{
            "width":354,
            "height":82
         },
         "medium":{
            "width":430,
            "height":82
         },
         "big":{
            "width":554,
            "height":120
         }
      };
       
      
      private var _currentSize:String;
      
      public function LunarNYWidget()
      {
         this._currentSize = HangarHeader.WINDOW_SIZE_BIG;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      public function updateSize(param1:String) : void
      {
         var _loc2_:String = param1;
         if(this._currentSize != _loc2_)
         {
            this._currentSize = _loc2_;
            invalidateSize();
         }
      }
      
      private function updateLayout() : void
      {
         setSize(BOUNDS[this._currentSize].width,BOUNDS[this._currentSize].height);
      }
   }
}

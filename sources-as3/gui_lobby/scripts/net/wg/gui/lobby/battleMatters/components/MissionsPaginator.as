package net.wg.gui.lobby.battleMatters.components
{
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.paginator.PaginationGroup;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionsPaginator extends PaginationGroup
   {
      
      private static const BUTTON_SIZE:int = 30;
      
      private static const SEPARATE_SIZE:int = 10;
      
      private static const BUTTON_OFFSET:int = 40;
       
      
      private var _separators:Vector.<Sprite> = null;
      
      public function MissionsPaginator()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Sprite = null;
         var _loc4_:IClassFactory = null;
         var _loc5_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.clearSeparators();
            _loc1_ = getProviderLength();
            if(_loc1_ != 0)
            {
               this._separators = new Vector.<Sprite>();
               _loc2_ = 0;
               _loc4_ = App.utils.classFactory;
               _loc5_ = 0;
               while(_loc5_ < _loc1_)
               {
                  if(_loc5_ < _loc1_ - 1)
                  {
                     _loc3_ = _loc4_.getComponent(Linkages.MISSION_PAGINATOR_SEPARATOR_UI,Sprite);
                     _loc3_.x = _loc2_ + BUTTON_SIZE;
                     _loc3_.y = SEPARATE_SIZE;
                     addChild(_loc3_);
                     this._separators.push(_loc3_);
                  }
                  _loc2_ += BUTTON_OFFSET;
                  _loc5_++;
               }
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.clearSeparators();
         super.onBeforeDispose();
      }
      
      private function clearSeparators() : void
      {
         var _loc1_:Sprite = null;
         if(this._separators != null)
         {
            for each(_loc1_ in this._separators)
            {
               removeChild(_loc1_);
            }
            this._separators.splice(0,this._separators.length);
            this._separators = null;
         }
      }
   }
}

package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   
   public class TypeAndLevelField extends NodeComponent
   {
       
      
      public var levelIcon:MovieClip;
      
      public function TypeAndLevelField()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         _deferredDispose = true;
         mouseEnabled = mouseChildren = false;
         super.configUI();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(_owner != null && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = _owner.getItemType();
            this.visible = _loc1_.length > 0;
            _loc2_ = !!_owner.isElite() ? "elite_" + _loc1_ : _loc1_;
            if(currentFrameLabel != _loc2_ && _labelHash[_loc2_])
            {
               gotoAndStop(_loc2_);
            }
            _loc3_ = _owner.getLevel();
            if(this.levelIcon != null && this.levelIcon.currentFrame != _loc3_)
            {
               this.levelIcon.visible = _loc3_ > -1;
               if(_loc3_ > -1 && this.levelIcon.currentFrame != _loc3_)
               {
                  this.levelIcon.gotoAndStop(_loc3_);
               }
            }
         }
         super.draw();
      }
   }
}

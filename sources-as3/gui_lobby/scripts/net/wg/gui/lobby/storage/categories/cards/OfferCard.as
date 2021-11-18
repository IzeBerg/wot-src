package net.wg.gui.lobby.storage.categories.cards
{
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class OfferCard extends BaseCard
   {
      
      private static const DOTS:String = "...";
       
      
      private var _commons:ICommons;
      
      public function OfferCard()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         sellButton.label = STORAGE.BUTTONLABEL_SELECT;
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         this._commons = null;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_data && isInvalid(InvalidationType.DATA))
         {
            this._commons.truncateHtmlTextMultiline(titleTF,_data.title,2,DOTS);
         }
         if(_data && isInvalid(InvalidationType.SIZE))
         {
            if(!_isOver)
            {
               _container.y = getContainerYRolloutPosition();
            }
         }
      }
      
      override protected function getRollOverTweens() : Vector.<Tween>
      {
         var _loc1_:Vector.<Tween> = super.getRollOverTweens();
         _loc1_.push(new Tween(FIRST_ANIMATION_DURATION,titleTF,{"alpha":0},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         }));
         return _loc1_;
      }
      
      override protected function getRollOutTweens() : Vector.<Tween>
      {
         var _loc1_:Vector.<Tween> = super.getRollOutTweens();
         _loc1_.push(new Tween(FIRST_ANIMATION_DURATION,titleTF,{"alpha":1},{"fastTransform":false}));
         return _loc1_;
      }
   }
}

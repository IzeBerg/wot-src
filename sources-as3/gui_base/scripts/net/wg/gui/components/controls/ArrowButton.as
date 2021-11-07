package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.helpers.ComponentStatesHelper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class ArrowButton extends BaseArrowButton
   {
      
      private static const MIN_HEIGHT:int = 48;
       
      
      public var borderStates:MovieClip = null;
      
      public function ArrowButton()
      {
         super();
         constraintsDisabled = true;
         preventAutosizing = true;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,Math.max(MIN_HEIGHT,param2));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:Number = height;
         scaleX = scaleY = 1;
         height = _loc1_;
         _deferredDispose = true;
      }
      
      override protected function onDispose() : void
      {
         if(stage)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,handleReleaseOutside,false);
         }
         this.borderStates = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = _newFrame;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(_loc1_)
            {
               this.borderStates.gotoAndPlay(_loc1_);
               arrowStates.gotoAndPlay(_loc1_);
            }
         }
         if(focusIndicator)
         {
            focusIndicator.width = width;
            focusIndicator.height = height;
         }
         this.borderStates.width = width;
         this.borderStates.height = hitMc.height = height;
         arrowStates.y = height - arrowStates.height >> 1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:Vector.<MovieClip> = new <MovieClip>[this.borderStates,arrowStates];
         App.utils.asserter.assert(ComponentStatesHelper.getInstance().compareStatesLabels(_loc1_),"Timeline labels in \'borderStates\' and \'arrowStates\' must be equals!");
         _loc1_.splice(0,_loc1_.length);
         _labelHash = UIComponent.generateLabelHash(this.borderStates);
      }
   }
}

package net.wg.gui.bootcamp.prebattleHints
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.bootcamp.controls.BCAnimatedHintBase;
   import net.wg.gui.bootcamp.prebattleHints.controls.CrosshairContainer;
   import net.wg.infrastructure.base.meta.IBCPrebattleHintsMeta;
   import net.wg.infrastructure.base.meta.impl.BCPrebattleHintsMeta;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.utils.Constraints;
   
   public class BCPrebattleHints extends BCPrebattleHintsMeta implements IBCPrebattleHintsMeta
   {
      
      private static const HINTS_VISIBILITY:String = "hintsVisibility";
       
      
      public var crosshairHint:CrosshairContainer = null;
      
      public var crewHint:BCAnimatedHintBase = null;
      
      public var modulesHint:BCAnimatedHintBase = null;
      
      public var hitpointsHint:BCAnimatedHintBase = null;
      
      public var sizeMc:Sprite = null;
      
      private var _visible:Vector.<String>;
      
      private var _hidden:Vector.<String>;
      
      private var _countCrew:int = 0;
      
      public function BCPrebattleHints()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.sizeMc.width = param1;
         this.sizeMc.height = param2;
         if(constraints)
         {
            constraints.update(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         constraints.removeAllElements();
         constraints.dispose();
         this.crosshairHint.dispose();
         this.crewHint.dispose();
         this.hitpointsHint.dispose();
         this.modulesHint.dispose();
         constraints = null;
         this.crosshairHint = null;
         this.crewHint = null;
         this.hitpointsHint = null;
         this.modulesHint = null;
         this.sizeMc = null;
         this._visible = null;
         this._hidden = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(this.crosshairHint.name,this.crosshairHint,Constraints.CENTER_H | Constraints.CENTER_V);
         constraints.addElement(this.crewHint.name,this.crewHint,Constraints.BOTTOM | Constraints.LEFT);
         constraints.addElement(this.hitpointsHint.name,this.hitpointsHint,Constraints.BOTTOM | Constraints.LEFT);
         constraints.addElement(this.modulesHint.name,this.modulesHint,Constraints.BOTTOM | Constraints.LEFT);
         this.crewHint.setLabel(BOOTCAMP.PREBATTLE_HINT_CREW);
         this.hitpointsHint.setLabel(BOOTCAMP.PREBATTLE_HINT_HP);
         this.modulesHint.setLabel(BOOTCAMP.PREBATTLE_HINT_MODULES);
         this.updateStage(App.appWidth,App.appHeight);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:DisplayObject = null;
         super.draw();
         if(isInvalid(HINTS_VISIBILITY))
         {
            _loc1_ = this._visible.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = constraints.getElement(this._visible[_loc2_]).clip;
               _loc3_.visible = true;
               if(_loc3_ is BCAnimatedHintBase)
               {
                  (_loc3_ as BCAnimatedHintBase).playAnimation();
               }
               _loc2_++;
            }
            _loc1_ = this._hidden.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = constraints.getElement(this._hidden[_loc2_]).clip;
               _loc3_.visible = false;
               _loc2_++;
            }
            this.changeCrewCount();
         }
      }
      
      override protected function setHintsVisibility(param1:Vector.<String>, param2:Vector.<String>) : void
      {
         this._visible = param1;
         this._hidden = param2;
         invalidate(HINTS_VISIBILITY);
      }
      
      public function as_setCrewCount(param1:int) : void
      {
         this._countCrew = param1;
         invalidate();
      }
      
      private function changeCrewCount() : void
      {
         var _loc1_:MovieClip = this.crewHint.animationMC["anim"];
         if(_loc1_)
         {
            _loc1_.gotoAndStop(this._countCrew);
         }
         else
         {
            DebugUtils.LOG_ERROR("animationMC has to include MovieClip with name \"anim\"!!!!!");
         }
      }
   }
}

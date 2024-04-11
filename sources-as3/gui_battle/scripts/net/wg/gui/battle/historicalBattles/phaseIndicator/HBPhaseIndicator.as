package net.wg.gui.battle.historicalBattles.phaseIndicator
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.IHBPhaseIndicatorMeta;
   import net.wg.infrastructure.base.meta.impl.HBPhaseIndicatorMeta;
   
   public class HBPhaseIndicator extends HBPhaseIndicatorMeta implements IHBPhaseIndicatorMeta
   {
       
      
      public var background:MovieClip = null;
      
      public var currentTf:TextField = null;
      
      public var totalTf:TextField = null;
      
      private var _current:int = 0;
      
      private var _total:int = 0;
      
      private var _isVisible:Boolean = false;
      
      public function HBPhaseIndicator()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.background = null;
         this.currentTf = null;
         this.totalTf = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._isVisible)
            {
               this.background.visible = true;
               this.currentTf.text = this._current.toString();
               this.totalTf.text = this._total.toString();
            }
            else
            {
               this.background.visible = false;
               this.currentTf.text = Values.EMPTY_STR;
               this.totalTf.text = Values.EMPTY_STR;
            }
         }
      }
      
      public function as_setData(param1:int, param2:int) : void
      {
         if(this._current != param1)
         {
            this._current = param1;
            invalidateData();
         }
         if(this._total != param2)
         {
            this._total = param2;
            invalidateData();
         }
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         if(this._isVisible != param1)
         {
            this._isVisible = param1;
            invalidateData();
         }
      }
   }
}

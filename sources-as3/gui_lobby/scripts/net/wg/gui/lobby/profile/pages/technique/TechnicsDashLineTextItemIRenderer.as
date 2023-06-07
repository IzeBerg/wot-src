package net.wg.gui.lobby.profile.pages.technique
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.components.StatisticsDashLineTextItemIRenderer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TechnicsDashLineTextItemIRenderer extends StatisticsDashLineTextItemIRenderer
   {
      
      private static const PERCENT_SIGN:String = "%";
      
      private static const DEFAULT_WIDTH:int = 350;
      
      private static const VALUE_COLOR:uint = 15131353;
       
      
      private var _percentSignMC:MovieClip = null;
      
      public function TechnicsDashLineTextItemIRenderer()
      {
         super();
      }
      
      override public function receiveAndSetValue(param1:*, param2:uint, param3:Function = null) : void
      {
         var _loc4_:String = param1.toString();
         var _loc5_:Boolean = false;
         if(param1 && _loc4_.indexOf(PERCENT_SIGN) != -1)
         {
            _loc4_ = _loc4_.split(PERCENT_SIGN)[0];
            _loc5_ = true;
         }
         super.receiveAndSetValue(_loc4_,VALUE_COLOR,param3);
         if(_loc5_ && this._percentSignMC == null)
         {
            this._percentSignMC = App.utils.classFactory.getComponent(Linkages.TECHNIQUE_STATISTICS_PERCENT_SIGN,MovieClip);
            addChild(this._percentSignMC);
         }
         else if(!_loc5_ && this._percentSignMC)
         {
            removeChild(this._percentSignMC);
            this._percentSignMC = null;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         width = DEFAULT_WIDTH;
      }
      
      override protected function applySizeChanges() : void
      {
         super.applySizeChanges();
         if(this._percentSignMC)
         {
            this._percentSignMC.x = valueTextField.x + valueTextField.width >> 0;
            this._percentSignMC.y = valueTextField.y;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._percentSignMC is IDisposable)
         {
            IDisposable(this._percentSignMC).dispose();
         }
         this._percentSignMC = null;
         super.onDispose();
      }
   }
}

package net.wg.gui.battle.battleRoyale.views.playersPanel
{
   import com.gskinner.motion.GTweener;
   import com.gskinner.motion.plugins.ColorTransformPlugin;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.Image;
   
   public class ImageWrapper extends BattleUIComponent
   {
      
      private static const COLOR_CHANGE_DURATION:Number = 0.01;
       
      
      public var image:Image = null;
      
      private var _tintColor:uint = 2147483647;
      
      public function ImageWrapper()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         GTweener.removeTweens(this.image);
         this.image.dispose();
         this.image = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         ColorTransformPlugin.install();
      }
      
      public function setTint(param1:uint) : void
      {
         if(this._tintColor != param1)
         {
            GTweener.removeTweens(this.image);
            GTweener.to(this.image,COLOR_CHANGE_DURATION,{"tint":param1});
            this._tintColor = param1;
         }
      }
      
      public function set source(param1:String) : void
      {
         this.image.source = param1;
      }
   }
}

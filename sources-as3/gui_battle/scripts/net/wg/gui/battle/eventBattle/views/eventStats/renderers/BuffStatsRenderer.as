package net.wg.gui.battle.eventBattle.views.eventStats.renderers
{
   import flash.text.TextField;
   import net.wg.gui.battle.eventBattle.views.buffsPanel.EventBuffIcon;
   import net.wg.gui.battle.eventBattle.views.eventStats.VO.EventBuffsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class BuffStatsRenderer extends UIComponentEx implements IUpdatable
   {
       
      
      public var nameTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var iconLoader:EventBuffIcon = null;
      
      private var _data:EventBuffsVO = null;
      
      public function BuffStatsRenderer()
      {
         super();
      }
      
      public function update(param1:Object) : void
      {
         this._data = EventBuffsVO(param1);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.iconLoader.iconPath = this._data.imageName;
            this.nameTF.text = this._data.name;
            this.descriptionTF.text = this._data.description;
         }
      }
      
      override protected function onDispose() : void
      {
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.nameTF = null;
         this.descriptionTF = null;
         this._data = null;
         super.onDispose();
      }
   }
}

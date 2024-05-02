package net.wg.gui.lobby.battleResults.epic
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.battleResults.data.EpicEfficiencyData;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.gfx.TextFieldEx;
   
   public class EpicEfficiencyItemRenderer extends SoundButtonEx implements IListItemRenderer
   {
       
      
      public var ribbonNameLbl:TextField;
      
      public var ribbonCountLbl:TextField;
      
      public var iconLoader:UILoaderAlt;
      
      private var _dataVO:EpicEfficiencyData = null;
      
      private var _index:uint;
      
      public function EpicEfficiencyItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ribbonNameLbl.mouseEnabled = this.ribbonNameLbl.mouseEnabled = false;
         this.ribbonNameLbl.selectable = this.ribbonNameLbl.selectable = false;
         this.ribbonCountLbl.mouseEnabled = this.ribbonCountLbl.mouseEnabled = false;
         this.ribbonCountLbl.selectable = this.ribbonCountLbl.selectable = false;
         this.iconLoader.mouseEnabled = this.iconLoader.mouseEnabled = false;
         mouseEnabled = mouseChildren = false;
         TextFieldEx.setVerticalAlign(this.ribbonCountLbl,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._dataVO != null)
         {
            this.ribbonNameLbl.text = this._dataVO.name;
            this.ribbonCountLbl.text = this._dataVO.count;
            App.utils.commons.updateTextFieldSize(this.ribbonNameLbl,false,true);
            this.ribbonNameLbl.visible = true;
            this.ribbonCountLbl.visible = true;
         }
      }
      
      override protected function onDispose() : void
      {
         this.ribbonNameLbl = null;
         this.ribbonCountLbl = null;
         this.iconLoader.dispose();
         this.iconLoader = null;
         this._dataVO = null;
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return this._dataVO;
      }
      
      public function setData(param1:Object) : void
      {
         if(this._dataVO != param1)
         {
            if(this._dataVO != null)
            {
               this._dataVO.removeEventListener(Event.CHANGE,this.onDataVOChangeHandler);
               this._dataVO = null;
            }
            if(param1 != null)
            {
               this._dataVO = param1 as EpicEfficiencyData;
               this.updateData();
            }
         }
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      private function updateData() : void
      {
         this._dataVO.addEventListener(Event.CHANGE,this.onDataVOChangeHandler);
         if(this._dataVO.iconUrl)
         {
            this.iconLoader.source = this._dataVO.iconUrl;
         }
         invalidateData();
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      private function onDataVOChangeHandler(param1:Event) : void
      {
         this.updateData();
      }
   }
}

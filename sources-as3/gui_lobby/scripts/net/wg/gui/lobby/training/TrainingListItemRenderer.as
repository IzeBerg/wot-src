package net.wg.gui.lobby.training
{
   import flash.text.TextField;
   import net.wg.data.VO.TrainingFormRendererVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.TrainingEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Constraints;
   
   public class TrainingListItemRenderer extends ListItemRenderer
   {
       
      
      public var iconLoader:UILoaderAlt;
      
      public var textOwner:TextField;
      
      public var textArena:TextField;
      
      public var textComment:TextField;
      
      public var textCount:TextField;
      
      private var _itemClicked:Boolean = false;
      
      private var _dataVO:TrainingFormRendererVO;
      
      public function TrainingListItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = param1;
         this._itemClicked = false;
         if(param1)
         {
            if(this._dataVO != null)
            {
               this._dataVO.dispose();
            }
            this._dataVO = new TrainingFormRendererVO(param1);
         }
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.visible = false;
         focusTarget = owner;
         constraints.addElement(this.textComment.name,this.textComment,Constraints.ALL);
         constraints.addElement(this.textArena.name,this.textArena,Constraints.ALL);
         constraints.addElement(this.textCount.name,this.textCount,Constraints.RIGHT);
         constraints.addElement(this.textOwner.name,this.textOwner,Constraints.RIGHT);
         this.iconLoader.hideLoader = true;
         this.addEventListener(ButtonEvent.CLICK,this.onClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.textOwner = null;
         this.textArena = null;
         this.textComment = null;
         this.textCount = null;
         if(this._dataVO != null)
         {
            this._dataVO.dispose();
            this._dataVO = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(data)
            {
               this.visible = true;
               this.textComment.text = this._dataVO.comment;
               this.textArena.text = this._dataVO.arena;
               this.textCount.text = this._dataVO.count + "/" + 2 * this._dataVO.total;
               App.utils.commons.formatPlayerName(this.textOwner,App.utils.commons.getUserProps(this._dataVO.creatorName,this._dataVO.creatorClan,this._dataVO.creatorRegion,this._dataVO.creatorIgrType,null));
               this.iconLoader.visible = true;
               if(this.iconLoader.source != this._dataVO.icon)
               {
                  this.iconLoader.source = this._dataVO.icon;
               }
               constraints.update(_width,_height);
               this.enabled = !(this._dataVO.disabled || this._itemClicked);
            }
            else
            {
               this.visible = false;
            }
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(super.enabled == param1)
         {
            return;
         }
         super.enabled = param1;
      }
      
      private function onClickHandler(param1:ButtonEvent) : void
      {
         this._itemClicked = true;
         this.enabled = false;
         dispatchEvent(new TrainingEvent(TrainingEvent.OPEN_TRAINING_ROOM,{"id":this._dataVO.id}));
      }
   }
}
